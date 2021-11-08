# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  description = "The OCID of tenancy"
  type        = string
}

variable "budget_amount" {
  description = "The amount of the budget expressed as a whole number in the currency of the customer's rate card."
  default     = null
  type        = string
}

variable "budget_target_name" {
  description = "The compartment name for the budget"
  type        = string
}

variable "budget_target" {
  description = "The compartment ocid for the budget"
  type        = string
}

variable "budget_alert_rule_threshold" {
  description = "The target for the budget"
  type        = number
}

variable "budget_alert_rule_recipients" {
  description = "The type of alert for the budget"
  type        = string
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}
# -----------------------------------------------------------------------------
# Optional inputs and values to override
# -----------------------------------------------------------------------------
variable "budget_reset_period" {
  description = "The reset period for the budget."
  default     = "MONTHLY"
  type        = string
}

variable "budget_target_type" {
  description = "The target type for the budget"
  default     = "COMPARTMENT"
  type        = string
}

variable "budget_alert_rule_threshold_type" {
  description = "The threshold type for the budget"
  default     = "ABSOLUTE"
  type        = string
}

variable "budget_alert_rule_type" {
  description = "The type of alert for the budget"
  default     = "ACTUAL"
  type        = string
}

variable "budget_alert_rule_message" {
  description = "The alert message for budget alerts."
  default     = "Default budget alert"
  type        = string
}