variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
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

# ---------------------------------------------------------------------------------------------------------------------
# Optional suffix string to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
variable "suffix" {
  type        = string
  description = "Optional suffix string used in a resource name"
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

variable "security_compartment_id" {
  type        = string
  description = "The OCID of the network compartment"
}

variable "security_compartment_name" {
  type        = string
  description = "The name for the network compartment"
}

# -----------------------------------------------------------------------------
# IAM Policy Variables
# -----------------------------------------------------------------------------
variable "network_admin_policy_name" {
  type        = string
  default     = "OCI-LZ-VCN-Admin-Policy"
  description = "Policy name for Network Administrators"
}

variable "security_admins_policy_name" {
  type        = string
  description = "The name of the security admin group"
  default     = "OCI-LZ-Security-Admins"
}

variable "cloud_guard_analysts_policy_name" {
  type        = string
  description = "The name of the Cloud Guard Analyst group"
  default     = "OCI-LZ-CG-Ops"
}

variable "cloud_guard_operators_policy_name" {
  type        = string
  default     = "OCI-LZ-CG-Users"
  description = "Policy name for Cloud Guard Operator"
}

variable "cloud_guard_architects_policy_name" {
  type        = string
  default     = "OCI-LZ-CG-Admins"
  description = "Policy name for Cloud Guard Operator"
}

variable "platform_admin_policy_name" {
  type        = string
  default     = "OCI-LZ-Platform-Admins"
  description = "Policy name for Platform Admin"
}

variable "iam_admin_policy_name" {
  type        = string
  default     = "OCI-LZ-IAM-Admins"
  description = "Policy name for IAM Admin"
}

variable "ops_admin_policy_name" {
  type        = string
  default     = "OCI-LZ-Ops-Admins"
  description = "Policy name for Ops Admin"
}

# -----------------------------------------------------------------------------
# IAM Group Variables
# -----------------------------------------------------------------------------
variable "network_admin_group_name" {
  type        = string
  description = "Group name for Network Administrators"
}

variable "security_admins_group_name" {
  type        = string
  description = "The name for the Security Admins group name"
}

variable "iam_admin_group_name" {
  type        = string
  description = "The name for the IAM Admin group"
}

variable "platform_admin_group_name" {
  type        = string
  description = "The name for the Platform Admin group"
}

variable "ops_admin_group_name" {
  type        = string
  description = "The name for the Ops Admin group"
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
