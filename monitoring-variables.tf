variable "network_admin_email_endpoints" {
  type        = list(string)
  description = "List of email addresses for all network related notifications."
  validation {
    condition     = length([for e in var.network_admin_email_endpoints : e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]) == length(var.network_admin_email_endpoints)
    error_message = "Validation failed network_admin_email_endpoints: invalid email address."
  }
}

variable "security_admin_email_endpoints" {
  type        = list(string)
  description = "List of email addresses for all security related notifications."
  validation {
    condition     = length([for e in var.security_admin_email_endpoints : e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]) == length(var.security_admin_email_endpoints)
    error_message = "Validation failed security_admin_email_endpoints: invalid email address."
  }
}

variable "budget_admin_email_endpoints" {
  type        = list(string)
  description = "List of email addresses for all budget related notifications."
  validation {
    condition     = length([for e in var.budget_admin_email_endpoints : e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]) == length(var.budget_admin_email_endpoints)
    error_message = "Validation failed budget_admin_email_endpoints: invalid email address."
  }
}