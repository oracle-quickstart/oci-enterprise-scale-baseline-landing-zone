terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci]
    }
  }
}

resource "oci_identity_user" "break_glass_user" {
    compartment_id = var.tenancy_ocid
    description    = "Break glass user ${var.break_glass_user_index}"
    name           = "break_glass_user_${var.break_glass_user_index}${var.suffix}"
    email          = var.break_glass_user_email
    freeform_tags  = {
      "Description"  = "Break glass users",
      "CostCenter"   = var.tag_cost_center,
      "GeoLocation"  = var.tag_geo_location
  }
}