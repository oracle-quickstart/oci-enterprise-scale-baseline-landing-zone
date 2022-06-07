# -----------------------------------------------------------------------------
# Topics Variables
# -----------------------------------------------------------------------------
variable "security_topic_name" {
  type        = string
  description = "The name of security topic"
  default     = "Security-Topic"
}

variable "network_topic_name" {
  type        = string
  description = "The name of network topic"
  default     = "Network-Topic"
}

variable "budget_topic_name" {
  type        = string
  description = "The name of budget topic"
  default     = "Budget-Topic"
}

# -----------------------------------------------------------------------------
# Subscription Variables
# -----------------------------------------------------------------------------
variable "subscription_protocol" {
  type        = string
  description = "The protocol used for the subscription"
  default     = "EMAIL"
}

variable "security_admin_email_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for all security related notifications."
  validation {
    condition     = length([for e in var.security_admin_email_endpoints : e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]) == length(var.security_admin_email_endpoints)
    error_message = "Validation failed security_admin_email_endpoints: invalid email address."
  }
}

variable "budget_admin_email_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for all budget related notifications."
  validation {
    condition     = length([for e in var.budget_admin_email_endpoints : e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]) == length(var.budget_admin_email_endpoints)
    error_message = "Validation failed budget_admin_email_endpoints: invalid email address."
  }
}

variable "network_admin_email_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for all network related notifications."
  validation {
    condition     = length([for e in var.network_admin_email_endpoints : e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]) == length(var.network_admin_email_endpoints)
    error_message = "Validation failed network_admin_email_endpoints: invalid email address."
  }
}

# -----------------------------------------------------------------------------
# Notification Rules Variables
# -----------------------------------------------------------------------------
variable "notification_action_type" {
  type        = string
  description = "The action to perform if the condition in the rule matches an event. Available options: ONS, OSS, FAAS"
  default     = "ONS"
}

variable "notification_action_description" {
  type        = string
  description = "The details of the action"
  default     = "Sends notification via ONS"
}

variable "enable_iam_notification_action" {
  type        = bool
  description = "Whether or not the iam notification action is currently enabled"
  default     = true
}

variable "iam_notification_display_name" {
  type        = string
  description = "the display name of iam notification rule"
  default     = "Iam-Change-Notification"
}

variable "network_notification_display_name" {
  type        = string
  description = "the display name of network notification rule"
  default     = "Network-Change-Notification"
}

variable "enable_network_notification_action" {
  type        = bool
  description = "Whether or not the network notification action is currently enabled"
  default     = true
}

variable "enable_iam_notification_rule" {
  type        = bool
  description = "Whether or not the iam rule is currently enabled"
  default     = true
}

variable "iam_notification_description" {
  type        = string
  description = "Details of the iam notification rule"
  default     = "Events rule to detect when IAM resources are created, updated or deleted"
}

variable "enable_network_notification_rule" {
  type        = bool
  description = "Whether or not the network rule is currently enabled"
  default     = true
}

variable "network_notification_description" {
  type        = string
  description = "Details of the network notification rule"
  default     = "Events rule to detect when network resources are created, updated or deleted"
}

variable "enable_budget_notification_action" {
  type        = bool
  description = "Whether or not the budget notification action is currently enabled"
  default     = true
}

variable "budget_notification_display_name" {
  type        = string
  description = "the display name of budget notification rule"
  default     = "Budget-Change-Notification"
}

variable "enable_budget_notification_rule" {
  type        = bool
  description = "Whether or not the budget rule is currently enabled"
  default     = true
}

variable "budget_notification_description" {
  type        = string
  description = "Details of the budget notification rule"
  default     = "Events rule to detect when budget resources are created, updated or deleted"
}