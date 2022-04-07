variable "compartment_id" {
  type        = string
  description = "the compartment oci where the notification rules live on"
}

variable "notification_action_type" {
  type        = string
  description = "The action to perform if the condition in the rule matches an event. Available options: ONS, OSS, FAAS"
}

variable "enable_budget_notification_action" {
  type        = string
  description = "Whether or not this action is currently enabled"
}

variable "enable_budget_notification_rule" {
  type        = bool
  description = "Whether or not the budget rule is currently enabled"
}

variable "topic_id" {
  type        = string
  description = "The OCID of the budget topic for the subscription"
}

variable "budget_notification_display_name" {
  type        = string
  description = "the display name of budget notification rule"
}

variable "notification_action_description" {
  type        = string
  description = "The details of the action"
}

variable "budget_notification_description" {
  type        = string
  description = "Details of the budget notification rule"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

variable "suffix" {
  type        = string
  description = "Suffix string used in a resource name to prevent naming collision with tenancy level resources"
}