resource "oci_monitoring_alarm" "these" {
  #Required
  for_each = var.alarms
  compartment_id        = each.value.compartment_id
  destinations          = each.value.destinations
  display_name          = each.value.display_name
  is_enabled            = each.value.is_enabled
  metric_compartment_id = each.value.metric_compartment_id
  namespace             = each.value.namespace
  query                 = each.value.query
  severity              = each.value.severity
  message_format        = each.value.message_format
  pending_duration      = each.value.pending_duration
  freeform_tags         = each.value.freeform_tags
}