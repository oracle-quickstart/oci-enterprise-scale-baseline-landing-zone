variable "region" {
  type        = string
  description = "the OCI region"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "current_user_ocid" {
  type        = string
  description = "OCID of the current user"
}

variable "api_fingerprint" {
  type        = string
  description = "The fingerprint of API"
}

variable "api_private_key_path" {
  type        = string
  description = "The local path to the API private key"
}

# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------

variable "parent_compartment_name" {
  type        = string
  description = "Name of the top level / parent compartment"
}

variable "tag_cost_center" {
  type        = string
  description = "CostCenter tag value"
}

variable "tag_geo_location" {
  type        = string
  description = "GeoLocation tag value"
}

variable "workload_compartment_names" {
  type        = list(string)
  description = "List of application workload compartment names"
}

# -----------------------------------------------------------------------------
# Optional inputs
# -----------------------------------------------------------------------------

variable "network_compartment_name" {
  type        = string
  description = "Name of the top level / parent compartment"
  default     = "network"
}

variable "security_compartment_name" {
  type        = string
  description = "Name of the top level / parent compartment"
  default     = "security"
}

variable "common_infra_compartment_name" {
  type        = string
  description = "Name of the top level / parent compartment"
  default     = "common-infra"
}

variable "applications_compartment_name" {
  type        = string
  description = "Name of the top level / parent compartment"
  default     = "applications"
}