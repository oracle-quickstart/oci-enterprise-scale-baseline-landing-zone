variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "workload_compartment_ocids" {
  type        = map(map(string))
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

variable "parent_compartment_name" {
  type        = string
  description = "The name for the parent compartment"
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
  type        = string
  default     = "OCI-LZ-Admin-TenantAdminPolicy"
  description = "Policy name for Administrators"
}

variable "network_admin_policy_name" {
  type        = string
  default     = "OCI-LZ-VCNAdminPolicy"
  description = "Policy name for Network Administrators"
}

variable "security_admins_policy_name" {
  type        = string
  description = "The name of the security admin group"
  default     = "OCI-LZ-SecurityAdmins"
}

variable "cloudguard_analysts_policy_name" {
  type        = string
  description = "The name of the cloudguard analyst group"
  default     = "OCI-LZ-CGOps"
}

variable "cloud_guard_operators_policy_name" {
  type        = string
  default     = "OCI-LZ-CGUsers"
  description = "Policy name for Cloud Guard Operator"
}

variable "cloud_guard_architects_policy_name" {
  type        = string
  default     = "OCI-LZ-CGAdmins"
  description = "Policy name for Cloud Guard Operator"
}
# -----------------------------------------------------------------------------
# IAM Group Variables
# -----------------------------------------------------------------------------
variable "administrator_group_name" {
  type        = string
  description = "Group name for Administrators"
}

variable "network_admin_group_name" {
  type        = string
  description = "Group name for Network Administrators"
}

variable "lb_users_group_name" {
  type        = string
  description = "Group name for Load Balancer Users"
}

variable "workload_storage_admins_group_names" {
  type        = map(any)
  description = "Map of workload compartment names and group names for Workload Storage Administrators"
}

variable "workload_storage_users_group_names" {
  type        = map(any)
  description = "Map of workload compartment names and group names for Workload Storage Users"
}

variable "workload_admins_group_names" {
  type        = map(any)
  description = "Map of workload compartment names and group names for Workload Administrators"
}

variable "workload_users_group_names" {
  type        = map(any)
  description = "Map of workload compartment names and group names for Workload Users"
}

variable "security_admins_group_name" {
  type = string
}

variable "cloudguard_analysts_group_name" {
  type = string
}
variable "cloud_guard_operators_group_name" {
  type        = string
  description = "The name for the Cloud Guard Operator group name"
}

variable "cloud_guard_architects_group_name" {
  type        = string
  description = "The name for the Cloud Guard Architect group name"
}

variable "region" {
  type        = string
  description = "Region for use in object storage policy"
}

variable "key_id" {
  type        = string
  description = "Encryption key ocid for security admin policy"
}

variable "vault_id" {
  type        = string
  description = "Vault ocid for security admin policy"
}
