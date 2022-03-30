resource "oci_ons_notification_topic" "topics" {
  for_each       = var.topics
  compartment_id = each.value.compartment_id
  name           = each.value.name
  description    = each.value.description
  freeform_tags  = each.value.freeform_tags
}