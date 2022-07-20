terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
    }
  }
}

resource "oci_events_rule" "notification-rule" {
  for_each = var.rules
  actions {
    actions {
      action_type = each.value.actions_action_type
      is_enabled  = each.value.actions_is_enabled

      description = each.value.actions_description
      topic_id    = each.value.topic_id
    }
  }
  compartment_id = each.value.compartment_id
  condition      = each.value.condition
  display_name   = each.value.display_name
  is_enabled     = each.value.is_enabled
  description    = each.value.description
  freeform_tags  = each.value.freeform_tags
}