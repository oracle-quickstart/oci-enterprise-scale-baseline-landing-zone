variable "unique_prefix" {}
variable "tenancy_ocid" {}

variable "administrator_group_name" {
  type  = string
  default = "Administrator"
}

variable "administrator_policies_name" {
  type  = string
  default  = "administrator-group-policies"
}
