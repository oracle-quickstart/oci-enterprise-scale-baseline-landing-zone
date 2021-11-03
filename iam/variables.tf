variable "unique_prefix" {

}

variable "tenancy_ocid" {

}

variable "root_compartment_name" {
  type = string
}

variable "application_compartment_name" {
  type = string
}

variable "network_compartment_name" {
  type        = string
  description = "The name for the Network Compartment"
}

variable "network_compartment_ocid"{
  type        = string
  description = "The OCID for the Network Compartment"
}

variable "administrator_group_name" {
  type  = string
  default = "Administrators"
}

variable "administrator_policy_name" {
  type  = string
  default  = "OCI-LZ-Admin-TenantAdminPolicy"
}

variable "network_admin_group_name" {
  type  = string
  default = "Virtual-Network-Admins"
}

variable "network_admin_policy_name" {
  type  = string
  default  = "OCI-LZ-VCNAdminPolicy"
}
