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

# -----------------------------------------------------------------------------
# Tag Variables
# -----------------------------------------------------------------------------
variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}
