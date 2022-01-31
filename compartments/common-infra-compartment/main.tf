terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci]
    }
  }
}

# -----------------------------------------------------------------------------
# Create common infra compartment under parent compartment
# -----------------------------------------------------------------------------
resource "oci_identity_compartment" "common_infra_compartment" {
  compartment_id  = var.parent_compartment_ocid
  description     = "Common Infra Compartment"
  name            = var.compartment_name
  enable_delete   = var.is_sandbox_mode_enabled == true ? true : false

  freeform_tags = {
    "Description" = "Common Infra Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

resource "time_sleep" "wait_90_seconds" {
  depends_on      = [oci_identity_compartment.common_infra_compartment]
  create_duration = "90s"
}