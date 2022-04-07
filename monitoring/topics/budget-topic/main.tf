resource "oci_ons_notification_topic" "budget_topic" {
  compartment_id = var.compartment_id
  name           = "${var.budget_topic_name}-${var.suffix}"
  freeform_tags  = {
    "Description" = "Landing Zone topic for budget related notifications.",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}