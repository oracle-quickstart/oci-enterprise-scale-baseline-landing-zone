# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "budget_alerting" {
  description = "Set to true to enable budget alerting"
  type        = bool
  default     = false
}
variable "budget_amount" {
  description = "(Required if using budget alerts): The amount of the budget expressed as a number in the currency of the customer's rate card."
  type        = string
  default     = ""
}

variable "budget_alert_rule_threshold" {
  description = "(Required if using budget alerts): The target spending threshold for the budget"
  type        = string
  default     = ""
}

variable "budget_alert_rule_recipients" {
  description = "(Required if using budget alerts): Target email address for budget alerts"
  type        = string
  default     = ""
  validation {
    condition     = alltrue([for i in var.budget_alert_rule_recipients: can(regex("^([^\s@]+@([^\s@.,]+\.)+[^\s@.,]{2,})?$", i))])
    error_message = "Must be a list of valid email addresses."
  }
}

# -----------------------------------------------------------------------------
# Optional inputs and values to override
# -----------------------------------------------------------------------------
variable "budget_alert_rule_message" {
  description = "(Optional if using budget alerts): The alert message for budget alerts."
  default     = "Default budget alert"
  type        = string
}