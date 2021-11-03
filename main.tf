# ---------------------------------------------------------------------------------------------------------------------
# Provider block for home region and alternate region(s)
# ---------------------------------------------------------------------------------------------------------------------
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.api_fingerprint
  private_key_path = var.api_private_key_path
  region           = var.region
}

# ---------------------------------------------------------------------------------------------------------------------
# Create users
# ---------------------------------------------------------------------------------------------------------------------
module "users" {
  source                         = "./users"
  tenancy_ocid                   = var.tenancy_ocid
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Compartment 
# ---------------------------------------------------------------------------------------------------------------------
module "compartment" {
  source                         = "./compartment"
  tenancy_ocid                   = var.tenancy_ocid
  unique_prefix                  = var.unique_prefix
  workload_compartment_name_list = var.workload_compartment_name_list
}

# ---------------------------------------------------------------------------------------------------------------------
# Create IAM resources (policies, groups)
# ---------------------------------------------------------------------------------------------------------------------
module "iam" {
  source                         = "./iam"
  tenancy_ocid                   = var.tenancy_ocid
  unique_prefix                  = var.unique_prefix
  root_compartment_name          = module.compartment.root_compartment_name
  root_compartment_id            = module.compartment.root_compartment_id
  commoninfra_compartment_name   = module.compartment.commoninfra_compartment_name
  commoninfra_compartment_id     = module.compartment.commoninfra_compartment_id
  network_compartment_name       = module.compartment.network_compartment_name
  network_compartment_id         = module.compartment.network_compartment_id
  application_compartment_name   = module.compartment.application_compartment_name
  application_compartment_id     = module.compartment.application_compartment_id
  workload_compartment_name_list = var.workload_compartment_name_list
  break_glass_username_list      = var.break_glass_username_list
  depends_on = [
    module.compartment
  ]
}
