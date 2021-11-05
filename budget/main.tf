resource "oci_budget_budget" "oci_budget" {
  amount         = var.budget_amount
  compartment_id = var.tenancy_ocid
  reset_period   = var.budget_reset_period

  description  = "OCI Budget for compartment ${var.budget_target_name}"
  display_name = "${var.budget_target_name}-budget"
  target_type  = var.budget_target_type
  targets      = [ var.budget_target ]

  freeform_tags = {"Department"= "Finance"}
}

resource "oci_budget_alert_rule" "oci_budget_rule" {
  budget_id      = oci_budget_budget.oci_budget
  threshold      = var.alert_rule_threshold
  threshold_type = var.alert_rule_threshold_type
  type           = var.alert_rule_type

  description  = "OCI budget alert for compartment ${var.budget_target_name}"
  display_name = "${var.budget_target_name}-budget-alert"
  message       = var.alert_rule_message
  recipients    = var.alert_rule_recipients

  freeform_tags = {"Department"= "Finance"}
}