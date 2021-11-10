# -----------------------------------------------------------------------------
# Create budgeting for parent compartment
# -----------------------------------------------------------------------------
module "budget" {
  count = var.budget_alerting ? 1 : 0
  
  source                       = "./budget"
  tenancy_ocid                 = var.tenancy_ocid
  budget_target                = module.parent-compartment.parent_compartment_id
  budget_amount                = var.budget_amount
  budget_target_name           = var.parent_compartment_name
  budget_alert_rule_message    = var.budget_alert_rule_message
  budget_alert_rule_threshold  = var.budget_alert_rule_threshold
  budget_alert_rule_recipients = var.budget_alert_rule_recipients
  tag_geo_location             = var.tag_geo_location
  tag_cost_center              = var.tag_cost_center
}