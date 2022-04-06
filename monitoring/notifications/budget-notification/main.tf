resource "oci_events_rule" "budget_notification" {
  actions {
    actions {
      action_type = var.notification_action_type
      is_enabled  = var.enable_budget_notification_action
      description = var.notification_action_description
      topic_id    = var.topic_id
    }
  }
  compartment_id = var.compartment_id
  condition      = <<EOT
    {"eventType":
    ["com.oraclecloud.budgets.updatealertrule",
     "com.oraclecloud.budgets.deletealertrule",
     "com.oraclecloud.budgets.updatebudget",
     "com.oraclecloud.budgets.deletebudget"
    ]
    }
    EOT
  display_name = "${var.budget_notification_display_name}-${var.suffix}"
  is_enabled   = var.enable_budget_notification_rule
  description  = var.budget_notification_description
  freeform_tags  = {
    "Description" = "Landing Zone budget related events rules.",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}