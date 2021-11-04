variable "unique_prefix" {

}
variable "tenancy_ocid" {

}

variable "root_compartment_id" {
  type = string
}

variable "commoninfra_compartment_name" {
  type = string
}

variable "network_compartment_name" {
  type        = string
  description = "The name for the Network Compartment"
}

variable "administrator_group_name" {
  type    = string
  default = "Administrators"
}

variable "administrator_policy_name" {
  type    = string
  default = "OCI-LZ-Admin-TenantAdminPolicy"
}

variable "network_admin_group_name" {
  type    = string
  default = "Virtual-Network-Admins"
}

variable "network_admin_policy_name" {
  type    = string
  default = "OCI-LZ-VCNAdminPolicy"
}

variable "lb_users_group_name" {
  type    = string
  default = "LBUsers"
}

variable "workload_compartment_name_list" {
  type        = list(string)
  description = "Names of the Workload Compartments"
}

variable "break_glass_username_list" {
  type = list(string)
}
