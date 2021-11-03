terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create parent compartment under root compartment
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_compartment" "parent_compartment" {
  compartment_id  = var.tenancy_ocid
  description     = "Parent Compartment"
  name            = var.compartment_name
  freeform_tags = {
    "Description" = "Parent Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}


resource "time_sleep" "wait_90_seconds" {
  depends_on = [oci_identity_compartment.parent_compartment]
  create_duration = "90s"
}