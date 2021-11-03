terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create application compartment under parent compartment
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_compartment" "applications_compartment" {
  compartment_id  = var.parent_compartment_ocid
  description     = "Applications Compartment"
  name            = var.compartment_name
  freeform_tags = {
    "Description" = "Applications Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

resource "time_sleep" "wait_90_seconds" {
  depends_on = [oci_identity_compartment.applications_compartment]
  create_duration = "90s"
}