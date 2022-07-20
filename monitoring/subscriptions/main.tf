terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
    }
  }
}

resource "oci_ons_subscription" "subscription_service" {
  for_each = var.subscriptions
  compartment_id = each.value.compartment_id
  topic_id       = each.value.topic_id
  endpoint       = each.value.endpoint
  protocol       = each.value.protocol
  freeform_tags  = each.value.freeform_tags
}