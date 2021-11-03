terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci]
    }
  }
}

# -----------------------------------------------------------------------------
# Create networking compartment under parent compartment
# -----------------------------------------------------------------------------
resource "oci_identity_compartment" "network_compartment" {
  compartment_id  = var.common_infra_compartment_ocid
  description     = "Network Compartment"
  name            = var.compartment_name

  freeform_tags = {
    "Description" = "Network Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

resource "time_sleep" "wait_90_seconds" {
  depends_on      = [oci_identity_compartment.network_compartment]
  create_duration = "90s"
}