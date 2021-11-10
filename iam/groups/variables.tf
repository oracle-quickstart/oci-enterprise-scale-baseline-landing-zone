variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "random_group_name_id" {
  type        = string
  description = "Random unique string used in group name"
}

# -----------------------------------------------------------------------------
# Identity Compartment Variables
# -----------------------------------------------------------------------------
variable "workload_compartment_name_list" {
  type        = list(string)
  description = "List of application workload compartment names"
}

# -----------------------------------------------------------------------------
# IAM Group Variables
# -----------------------------------------------------------------------------
variable "administrator_group_name" {
  type        = string
  description = "The name for the administrator group"
  default     = "Administrators"
}

variable "network_admin_group_name" {
  type        = string
  description = "The name for the network administrator group name"
  default     = "Virtual-Network-Admins"
}

variable "lb_users_group_name" {
  type        = string
  description = "The name for the load balancer users group name"
  default     = "LBUsers"
}

variable "workload_storage_admins_group_name" {
  type        = string
  description = "The name for the workload storage administrators group"
  default     = "Workload-Storage-Admins"
}

variable "workload_storage_users_group_name" {
  type    = string
  description = "The name for the workload storage users group"
  default = "Workload-Storage-Users"
}

variable "workload_admins_group_name" {
  type    = string
  description = "The name for the workload administrators group"
  default = "Workload-Admins"
}

variable "workload_users_group_name" {
  type    = string
  description = "The name for the workload users group"
  default = "Workload-Users"
}