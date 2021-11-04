# -----------------------------------------------------------------------------
# Support for multi-region deployments
# -----------------------------------------------------------------------------
data "oci_identity_region_subscriptions" "regions" {
  tenancy_id = var.tenancy_ocid
}

locals {
  region_subscriptions = data.oci_identity_region_subscriptions.regions.region_subscriptions
  home_region          = [for region in local.region_subscriptions : region.region_name if region.is_home_region == true]
  region_key           = [for region in local.region_subscriptions : region.region_key if region.is_home_region == true]
}

# -----------------------------------------------------------------------------
# Provider blocks for home region and alternate region(s)
# -----------------------------------------------------------------------------
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.current_user_ocid
  fingerprint      = var.api_fingerprint
  private_key_path = var.api_private_key_path
  region           = var.region
}

provider "oci" {
  alias            = "home_region"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.current_user_ocid
  fingerprint      = var.api_fingerprint
  private_key_path = var.api_private_key_path
  region           = local.home_region[0]
}
