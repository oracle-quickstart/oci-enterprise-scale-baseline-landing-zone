terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci]
    }
  }
}

# -----------------------------------------------------------------------------
# Create workload compartment under parent compartment
# -----------------------------------------------------------------------------
resource "oci_identity_compartment" "workload_compartment" {
  compartment_id  = var.applications_compartment_ocid
  description     = "Compartment for ${var.compartment_name} workload"
  name            = var.compartment_name
  enable_delete   = var.compartment_delete_enabled

  freeform_tags = {
    "Description" = "${var.compartment_name} Workload Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

resource "time_sleep" "wait_90_seconds" {
  depends_on      = [oci_identity_compartment.workload_compartment]
  create_duration = "90s"
}