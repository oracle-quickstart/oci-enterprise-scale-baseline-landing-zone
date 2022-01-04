variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

# ---------------------------------------------------------------------------------------------------------------------
# Random IDs to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
variable "suffix" {
  type        = string
  description = "Random unique string used in a resource name"
}

# -----------------------------------------------------------------------------
# Identity Compartment Variables
# -----------------------------------------------------------------------------
variable "workload_compartment_name_list" {
  type        = list(string)
  description = "List of application workload compartment names"
}

# -----------------------------------------------------------------------------
# IAM Group Name Variables
# -----------------------------------------------------------------------------
variable "administrator_group_name" {
  type        = string
  description = "The name for the administrator group"
}

variable "network_admin_group_name" {
  type        = string
  description = "The name for the network administrator group name"
}

variable "lb_users_group_name" {
  type        = string
  description = "The name for the load balancer users group name"
}

variable "workload_storage_admins_group_name" {
  type        = string
  description = "The name for the workload storage administrators group"
}

variable "workload_storage_users_group_name" {
  type        = string
  description = "The name for the workload storage users group"
}

variable "workload_admins_group_name" {
  type        = string
  description = "The name for the workload administrators group"
}

variable "workload_users_group_name" {
  type        = string
  description = "The name for the workload users group"
}

variable "security_admins_group_name" {
  type        = string
  description = "The name of the security admin group"
}

variable "cloud_guard_operators_group_name" {
  type        = string
  description = "The name for the Cloud Guard Operator group name"
}

variable "cloud_guard_analysts_group_name" {
  type        = string
  description = "The name of the Cloud Guard Analyst group"
}

variable "cloud_guard_architects_group_name" {
  type        = string
  description = "The name for the Cloud Guard Architect group name"
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
