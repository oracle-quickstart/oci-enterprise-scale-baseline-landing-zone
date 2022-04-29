terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci]
    }
  }
}

resource "oci_budget_budget" "oci_budget" {
  amount         = var.budget_amount
  compartment_id = var.tenancy_ocid
  reset_period   = var.budget_reset_period

  description  = "OCI Budget for compartment ${var.budget_target_name}"
  display_name = "${var.budget_target_name}-budget"
  target_type  = var.budget_target_type
  targets      = [ var.budget_target ]

  freeform_tags = {
    "Description" = "Applications Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

resource "oci_budget_alert_rule" "oci_budget_rule" {
  budget_id      = oci_budget_budget.oci_budget.id
  threshold      = var.budget_alert_rule_threshold
  threshold_type = var.budget_alert_rule_threshold_type
  type           = var.budget_alert_rule_type

  description  = "OCI budget alert for compartment ${var.budget_target_name}"
  display_name = "${var.budget_target_name}-budget-alert"
  message       = var.budget_alert_rule_message
  recipients    = var.budget_alert_rule_recipients

  freeform_tags = {
    "Description" = "Applications Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}
