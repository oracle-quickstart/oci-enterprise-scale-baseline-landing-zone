variable "parent_compartment_id" {
  type        = string
  description = "The OCID of the parent compartment"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of the tenancy"
}

variable "release_tag_default_value" {
  type        = string
  description = "value of the release tag default value"
  default     = "1.0.0"
}

variable "namespace_name" {
  type    = string
  default = "ArchitectureCenter\\oci-enterprise-scale-baseline-landing-zone"
}
