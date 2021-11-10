# -----------------------------------------------------------------------------
# Create Parent compartment, for top level organization
# -----------------------------------------------------------------------------
module "parent-compartment" {
  source           = "./identity-compartments/parent-compartment"
  tenancy_ocid     = var.tenancy_ocid
  compartment_name = var.parent_compartment_name
  tag_geo_location = var.tag_geo_location
  tag_cost_center  = var.tag_cost_center
  providers        = {
    oci = oci.home_region
  }
}

# -----------------------------------------------------------------------------
# Create compartment for common infrastructure compartments
# -----------------------------------------------------------------------------
module "common-infra-compartment" {
  source                  = "./identity-compartments/common-infra-compartment"
  parent_compartment_ocid = module.parent-compartment.parent_compartment_id
  compartment_name        = var.common_infra_compartment_name
  tag_geo_location        = var.tag_geo_location
  tag_cost_center         = var.tag_cost_center
  providers               = {
    oci = oci.home_region
  }
  depends_on = [ module.parent-compartment ]
}

# -----------------------------------------------------------------------------
# Create compartment for application compartments
# -----------------------------------------------------------------------------
module "applications-compartment" {
  source                  = "./identity-compartments/applications-compartment"
  parent_compartment_ocid = module.parent-compartment.parent_compartment_id
  compartment_name        = var.applications_compartment_name
  tag_geo_location        = var.tag_geo_location
  tag_cost_center         = var.tag_cost_center
  providers               = {
    oci = oci.home_region
  }
  depends_on = [ module.parent-compartment ]
}

# -----------------------------------------------------------------------------
# Create compartment for network components
# -----------------------------------------------------------------------------
module "network-compartment" {
  source                        = "./identity-compartments/network-compartment"
  common_infra_compartment_ocid = module.common-infra-compartment.common_infra_compartment_id
  compartment_name              = var.network_compartment_name
  tag_geo_location              = var.tag_geo_location
  tag_cost_center               = var.tag_cost_center
  providers                     = {
    oci = oci.home_region
  }
  depends_on = [ module.common-infra-compartment ]
}

# -----------------------------------------------------------------------------
# Create compartment for security components
# -----------------------------------------------------------------------------
module "security-compartment" {
  source                        = "./identity-compartments/security-compartment"
  common_infra_compartment_ocid = module.common-infra-compartment.common_infra_compartment_id
  compartment_name              = var.security_compartment_name
  tag_geo_location              = var.tag_geo_location
  tag_cost_center               = var.tag_cost_center
  providers                     = {
    oci = oci.home_region
  }
  depends_on = [ module.common-infra-compartment ]
}

# -----------------------------------------------------------------------------
# Create compartment(s) for application specific workloads
# -----------------------------------------------------------------------------
module "workload-compartment" {
  for_each                      = toset(var.workload_compartment_names)
  compartment_name              = each.value
  source                        = "./identity-compartments/workload-compartment"
  applications_compartment_ocid = module.applications-compartment.applications_compartment_id
  tag_geo_location              = var.tag_geo_location
  tag_cost_center               = var.tag_cost_center
  providers                     = {
    oci = oci.home_region
  }
  depends_on = [ module.applications-compartment ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Create IAM resources (policies, groups)
# ---------------------------------------------------------------------------------------------------------------------
module "iam" {
  source                         = "./iam"
  tenancy_ocid                   = var.tenancy_ocid
  parent_compartment_id          = module.parent-compartment.parent_compartment_id
  network_compartment_id         = module.network-compartment.network_compartment_id
  network_compartment_name       = var.network_compartment_name
  workload_compartment_name_list = var.workload_compartment_names
  break_glass_username_list      = var.break_glass_username_list
  workload_compartment_ocids     = module.workload-compartment
  tag_cost_center                = var.tag_cost_center
  tag_geo_location               = var.tag_geo_location
  depends_on = [
    module.parent-compartment, module.network-compartment, module.workload-compartment
  ]
}

# -----------------------------------------------------------------------------
# Create VCN and subnets
# -----------------------------------------------------------------------------
module "vcn" {
  source                                                        = "./vcn"
  compartment_ocid                                              = module.network-compartment.network_compartment_id
  vcn_cidr_block                                                = var.vcn_cidr_block
  vcn_dns_label                                                 = var.vcn_dns_label
  region_key                                                    = local.region_key[0]
  workload_compartment_names                                    = var.workload_compartment_names
  public_subnet_cidr_block                                      = var.public_subnet_cidr_block
  public_subnet_dns_label                                       = var.public_subnet_dns_label
  private_subnet_cidr_blocks                                    = var.private_subnet_cidr_blocks
  private_subnet_dns_labels                                     = var.private_subnet_dns_labels
  database_subnet_dns_labels                                    = var.database_subnet_dns_labels
  database_subnet_cidr_blocks                                   = var.database_subnet_cidr_blocks
  shared_service_subnet_cidr_block                              = var.shared_service_subnet_cidr_block
  shared_service_subnet_dns_label                               = var.shared_service_subnet_dns_label
  tag_geo_location                                              = var.tag_geo_location
  tag_cost_center                                               = var.tag_cost_center
  egress_security_rules_protocol                                = var.egress_security_rules_protocol
  egress_security_rules_tcp_options_destination_port_range_max  = var.egress_security_rules_tcp_options_destination_port_range_max
  egress_security_rules_tcp_options_destination_port_range_min  = var.egress_security_rules_tcp_options_destination_port_range_min
  egress_security_rules_tcp_options_source_port_range_max       = var.egress_security_rules_tcp_options_source_port_range_max
  egress_security_rules_tcp_options_source_port_range_min       = var.egress_security_rules_tcp_options_source_port_range_min
  ingress_security_rules_protocol                               = var.ingress_security_rules_protocol
  ingress_security_rules_tcp_options_destination_port_range_max = var.ingress_security_rules_tcp_options_destination_port_range_max
  ingress_security_rules_tcp_options_destination_port_range_min = var.ingress_security_rules_tcp_options_destination_port_range_min
  ingress_security_rules_tcp_options_source_port_range_max      = var.ingress_security_rules_tcp_options_source_port_range_max
  ingress_security_rules_tcp_options_source_port_range_min      = var.ingress_security_rules_tcp_options_source_port_range_min
  ingress_security_rules_description                            = var.ingress_security_rules_description
  depends_on                                                    = [ module.network-compartment ]
}
