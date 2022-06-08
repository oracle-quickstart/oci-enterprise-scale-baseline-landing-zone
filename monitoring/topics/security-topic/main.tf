terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci]
    }
  }
}

resource "oci_ons_notification_topic" "security_topic" {
  compartment_id = var.compartment_id
  name           = "${var.security_topic_name}-${var.suffix}"
  freeform_tags  = {
    "Description" = "Landing Zone topic for security related notifications.",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

