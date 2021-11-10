variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "workload_compartment_ocids" {
  description = "The list of workload compartments"
}

variable "random_policy_name_id" {
  type        = string
  description = "Random unique string used in group name"
}

# -----------------------------------------------------------------------------
# Identity Compartment Variables
# -----------------------------------------------------------------------------
variable "parent_compartment_id" {
  type        = string
  description = "The OCID of the top level / parent compartment"
}

variable "network_compartment_id" {
  type        = string
  description = "The OCID of the network compartment"
}

variable "network_compartment_name" {
  type        = string
  description = "The name for the network compartment"
}

variable "workload_compartment_name_list" {
  type        = list(string)
  description = "List of application workload compartment names"
}

# -----------------------------------------------------------------------------
# IAM Policy Variables
# -----------------------------------------------------------------------------
variable "administrator_policy_name" {
  type    = string
  default = "OCI-LZ-Admin-TenantAdminPolicy"
}

variable "network_admin_policy_name" {
  type    = string
  default = "OCI-LZ-VCNAdminPolicy"
}

# -----------------------------------------------------------------------------
# IAM Group Variables
# -----------------------------------------------------------------------------

variable "administrator_group_name" {
  type = string
}

variable "network_admin_group_name" {
  type = string
}

variable "lb_users_group_name" {
  type = string
}

variable "workload_storage_admins_group_names" {
  type = map(map(string))
}

variable "workload_storage_users_group_names" {
  type = map(map(string))
}

variable "workload_admins_group_names" {
  type = map(map(string))
}

variable "workload_users_group_names" {
  type = map(map(string))
}
