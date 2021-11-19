# -----------------------------------------------------------------------------
# Create Parent compartment, for top level organization
# -----------------------------------------------------------------------------
module "parent-compartment" {
  source           = "./identity-compartments/parent-compartment"
  tenancy_ocid     = var.tenancy_ocid
  compartment_name = var.parent_compartment_name
  tag_geo_location = var.tag_geo_location
  tag_cost_center  = var.tag_cost_center
  providers = {
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
  providers = {
    oci = oci.home_region
  }
  depends_on = [module.parent-compartment]
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
  providers = {
    oci = oci.home_region
  }
  depends_on = [module.parent-compartment]
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
  providers = {
    oci = oci.home_region
  }
  depends_on = [module.common-infra-compartment]
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
  providers = {
    oci = oci.home_region
  }
  depends_on = [module.common-infra-compartment]
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
  providers = {
    oci = oci.home_region
  }
  depends_on = [module.applications-compartment]
}

# -----------------------------------------------------------------------------
# Create IAM resources (policies, groups)
# -----------------------------------------------------------------------------
module "iam" {
  source                         = "./iam"
  tenancy_ocid                   = var.tenancy_ocid
  parent_compartment_id          = module.parent-compartment.parent_compartment_id
  parent_compartment_name        = var.parent_compartment_name
  network_compartment_id         = module.network-compartment.network_compartment_id
  network_compartment_name       = var.network_compartment_name
  workload_compartment_name_list = var.workload_compartment_names
  break_glass_username_list      = var.break_glass_username_list
  workload_compartment_ocids     = module.workload-compartment
  region                         = var.region
  key_id                         = var.key_id
  vault_id                       = var.vault_id
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
  source                           = "./vcn"
  compartment_ocid                 = module.network-compartment.network_compartment_id
  vcn_cidr_block                   = var.vcn_cidr_block
  vcn_dns_label                    = var.vcn_dns_label
  region_key                       = local.region_key[0]
  workload_compartment_names       = var.workload_compartment_names
  public_subnet_cidr_block         = var.public_subnet_cidr_block
  public_subnet_dns_label          = var.public_subnet_dns_label
  private_subnet_cidr_blocks       = var.private_subnet_cidr_blocks
  private_subnet_dns_labels        = var.private_subnet_dns_labels
  database_subnet_dns_labels       = var.database_subnet_dns_labels
  database_subnet_cidr_blocks      = var.database_subnet_cidr_blocks
  shared_service_subnet_cidr_block = var.shared_service_subnet_cidr_block
  shared_service_subnet_dns_label  = var.shared_service_subnet_dns_label
  tag_geo_location                 = var.tag_geo_location
  tag_cost_center                  = var.tag_cost_center
  ingress_rules_map                = var.ingress_rules_map
  egress_rules_map                 = var.egress_rules_map
  depends_on                       = [module.network-compartment]
}

# -----------------------------------------------------------------------------
# Create Cloud Guard resources
# -----------------------------------------------------------------------------
module "cloud-guard" {
  source                                                     = "./security/cloud-guard"
  region                                                     = var.region
  activity_detector_recipe_display_name                      = var.activity_detector_recipe_display_name
  cloud_guard_configuration_status                           = var.cloud_guard_configuration_status
  configuration_detector_recipe_display_name                 = var.configuration_detector_recipe_display_name
  host_scan_recipe_agent_settings_agent_configuration_vendor = var.host_scan_recipe_agent_settings_agent_configuration_vendor
  host_scan_recipe_agent_settings_scan_level                 = var.host_scan_recipe_agent_settings_scan_level
  host_scan_recipe_port_settings_scan_level                  = var.host_scan_recipe_port_settings_scan_level
  agent_cis_benchmark_settings_scan_level                    = var.agent_cis_benchmark_settings_scan_level
  vss_scan_schedule                                          = var.vss_scan_schedule
  host_scan_recipe_display_name                              = var.host_scan_recipe_display_name
  host_scan_target_display_name                              = var.host_scan_target_display_name
  host_scan_target_description                               = var.host_scan_target_description
  parent_compartment_ocid                                    = module.parent-compartment.parent_compartment_id
  security_compartment_ocid                                  = module.security-compartment.security_compartment_id
  tenancy_ocid                                               = var.tenancy_ocid
  tag_geo_location                                           = var.tag_geo_location
  tag_cost_center                                            = var.tag_cost_center
  parent_compartment_name                                    = var.parent_compartment_name
  depends_on                                                 = [
    module.parent-compartment, module.common-infra-compartment, module.security-compartment
  ]
}

# -----------------------------------------------------------------------------
# Create Bastion resources
# -----------------------------------------------------------------------------
module "bastion" {
  source                               = "./security/bastion"
  vcn_id                               = module.vcn.vcn_id
  tag_geo_location                     = var.tag_geo_location
  tag_cost_center                      = var.tag_cost_center
  bastion_subnet_cidr_block            = var.bastion_subnet_cidr_block
  bastion_type                         = var.bastion_type
  bastion_client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  bastion_max_session_ttl_in_seconds   = var.bastion_max_session_ttl_in_seconds
  network_compartment_id               = module.network-compartment.network_compartment_id
  region_key                           = local.region_key[0]
  depends_on = [
    module.network-compartment

# -----------------------------------------------------------------------------
# Audit Logging
# -----------------------------------------------------------------------------
module "audit" {
  source                                     = "./security/audit"
  tenancy_ocid                               = var.tenancy_ocid
  parent_compartment_name                    = var.parent_compartment_name
  parent_compartment_ocid                    = module.parent-compartment.parent_compartment_id
  security_compartment_name                  = var.security_compartment_name
  security_compartment_ocid                  = module.security-compartment.security_compartment_id
  retention_rule_duration_time_amount        = var.retention_rule_duration_time_amount
  tag_geo_location                           = var.tag_geo_location
  tag_cost_center                            = var.tag_cost_center
 
  depends_on = [
    module.parent-compartment, module.security-compartment
  ]
}
