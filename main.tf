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
# Create Compartment resources
# ---------------------------------------------------------------------------------------------------------------------
module "compartment" {
  source                   = "./compartment"
  tenancy_ocid             = var.tenancy_ocid
  unique_prefix            = var.unique_prefix
}

# ---------------------------------------------------------------------------------------------------------------------
# Create IAM resources (policies, groups)
# ---------------------------------------------------------------------------------------------------------------------
module "iam" {
  source                   = "./iam"
  tenancy_ocid             = var.tenancy_ocid
  unique_prefix            = var.unique_prefix
  root_compartment_name    = module.compartment.root_compartment_name
  network_compartment_name = module.compartment.common_infra_compartment_name
  application_compartment_name = module.compartment.application_compartment_name
}
