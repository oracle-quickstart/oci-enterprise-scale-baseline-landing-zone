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
# Create IAM resources (policies, groups)
# ---------------------------------------------------------------------------------------------------------------------
module "iam" {
  source           = "./iam"
  tenancy_ocid     = var.tenancy_ocid
  unique_prefix    = var.unique_prefix
}
