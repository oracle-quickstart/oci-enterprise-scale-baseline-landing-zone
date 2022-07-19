# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  description = "The OCID of tenancy"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaaxbchsnzhdxyoewmoqiqzvltba2ri7gijhbd2z5ybpgorv7yhxeeq"
}

variable "budget_amount" {
  description = "The amount of the budget expressed as a whole number in the currency of the customer's rate card."
  #default     = null
  type        = string
  default     = "10000"
}

variable "budget_target_name" {
  description = "The compartment name for the budget"
  type        = string
  default     = "budget-test-target-name"
}

variable "budget_target" {
  description = "The compartment ocid for the budget"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaaxbchsnzhdxyoewmoqiqzvltba2ri7gijhbd2z5ybpgorv7yhxeeq"
}

variable "budget_alert_rule_threshold" {
  description = "The target for the budget"
  type        = number
  default     = "100"
}

variable "budget_alert_rule_recipients" {
  description = "The type of alert for the budget"
  type        = string
  default     = "example3@test.com"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
  default = "example_tag_cost_center"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
  default     = "example_tag_geo_location"
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