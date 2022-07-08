# -----------------------------------------------------------------------------
# Budget Output
# -----------------------------------------------------------------------------

output "budget_id" {
  value = oci_budget_alert_rule.oci_budget_rule.budget_id
}

output "budget_amount" {
  value = oci_budget_budget.oci_budget.amount
}

output "budget_alert_rule"{
  value = oci_budget_alert_rule.oci_budget_rule.threshold
}