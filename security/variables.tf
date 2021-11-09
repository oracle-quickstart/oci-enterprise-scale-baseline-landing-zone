variable "parent_compartment_ocid" {
  type        = string
  description = "the parent compartment ocid"
}

variable "region" {
  type        = string
  description = "the OCI region"
}

variable "cloud_guard_configuration_status" {
  type        = string
  description = "the status of the Cloud Guard tenant"
}
