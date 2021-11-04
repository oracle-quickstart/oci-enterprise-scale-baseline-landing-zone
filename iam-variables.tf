# ---------------------------------------------------------------------------------------------------------------------
# Required inputs
# ---------------------------------------------------------------------------------------------------------------------
variable "region" {
  type        = string
  description = "the OCI region"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "user_ocid" {
  type        = string
  description = "The OCID of user"
}

variable "api_fingerprint" {
  type        = string
  description = "The fingerprint of API"
}

variable "api_private_key_path" {
  type        = string
  description = "The local path to the API private key"
}

# ---------------------------------------------------------------------------------------------------------------------
# Resource naming
# ---------------------------------------------------------------------------------------------------------------------
variable "unique_prefix" {
  type        = string
  description = "Unique prefix with four characters"
}

variable "workload_compartment_name_list" {
  type        = list(string)
  description = "Names of the Workload Compartments"
  default     = ["Workload-A", "Workload-B"]
}

variable "break_glass_username_list" {
  type        = list(string)
  default     = ["test_user_1", "test_user_2"]
}
