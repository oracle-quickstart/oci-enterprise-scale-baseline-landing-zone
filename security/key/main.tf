resource "oci_kms_key" "key" {
  #Required
  compartment_id = var.security_compartment_ocid
  display_name   = var.key_display_name

  key_shape {
    algorithm = var.key_shape_algorithm
    length    = var.key_shape_length
  }
  management_endpoint = var.key_management_endpoint

  freeform_tags = {
    "Description" = "Central Logging Group"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}