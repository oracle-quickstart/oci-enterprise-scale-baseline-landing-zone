resource "oci_ons_subscription" "network_subscription" {
  compartment_id = var.compartment_id
  endpoint       = var.endpoint
  protocol       = var.subscription_protocol
  topic_id       = var.topic_id
  freeform_tags  = {
    "Description" = "Landing Zone network related subscription.",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}