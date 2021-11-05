variable "tenancy_ocid" {
  description = "The OCID of tenancy"
  type        = string
}

variable "budget_amount" {
  descripton = "The amount of the budget expressed as a whole number in the currency of the customer's rate card."
  type       = number
}

variable "budget_target_name" {
  description = "The compartment name for the budget"
  type        = string
}

variable "budget_target" {
  description = "The compartment ocid for the budget"
  type        = string
}

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

variable "alert_rule_threshold" {}
variable "alert_rule_threshold_type" {}
variable "alert_rule_type" {}
variable "alert_rule_description" {}
variable "alert_rule_display_name" {}
variable "alert_rule_message" {}
variable "alert_rule_recipients" {}