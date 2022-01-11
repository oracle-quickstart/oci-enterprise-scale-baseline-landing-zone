# -----------------------------------------------------------------------------
# Create Parent compartment, for top level organization
# -----------------------------------------------------------------------------
module "parent-compartment" {
  source           = "./compartments/parent-compartment"
  tenancy_ocid     = var.tenancy_ocid
  compartment_name = var.parent_compartment_name
  tag_geo_location = var.tag_geo_location
  tag_cost_center  = var.tag_cost_center
  suffix           = var.is_sandbox_mode_enabled == true ? "-${random_id.suffix.hex}" : ""
  
  providers = {
    oci = oci.home_region
  }
}

# -----------------------------------------------------------------------------
# Create compartment for common infrastructure compartments
# -----------------------------------------------------------------------------
module "common-infra-compartment" {
  source                  = "./compartments/common-infra-compartment"
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
  source                  = "./compartments/applications-compartment"
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
  source                        = "./compartments/network-compartment"
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
  source                        = "./compartments/security-compartment"
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
  source                        = "./compartments/workload-compartment"
  applications_compartment_ocid = module.applications-compartment.applications_compartment_id
  tag_geo_location              = var.tag_geo_location
  tag_cost_center               = var.tag_cost_center
  providers = {
    oci = oci.home_region
  }
  depends_on = [module.applications-compartment]
}