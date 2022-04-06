resource "oci_ons_notification_topic" "network_topic" {
  compartment_id = var.compartment_id
  name           = var.network_topic_name
  freeform_tags  = {
    "Description" = "Landing Zone topic for network related notifications.",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}