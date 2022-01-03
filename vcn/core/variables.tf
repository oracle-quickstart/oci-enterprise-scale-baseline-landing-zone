# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "compartment_ocid" {
  type        = string
  description = "Network compartment ocid"
}

variable "region_key" {
  type        = string
  description = "Region Key"
}

variable "workload_compartment_names" {
  type        = list(string)
  description = "List of application workload compartment names"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

# -----------------------------------------------------------------------------
# VCN Inputs
# -----------------------------------------------------------------------------
variable "vcn_cidr_block" {
  type        = string
  description = "Primary VCN CIDR Block"
}

variable "vcn_dns_label" {
  type        = string
  description = "VCN DNS Label"
}

# -----------------------------------------------------------------------------
# Private Subnet Inputs
# -----------------------------------------------------------------------------
variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of Private Subnet CIDR Block"
}

variable "private_subnet_dns_labels" {
  type        = list(string)
  description = "List of Private Subnet DNS Label"
}

# -----------------------------------------------------------------------------
# Database Subnet Inputs
# -----------------------------------------------------------------------------
variable "database_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of Database Subnet CIDR Block"
}

variable "database_subnet_dns_labels" {
  type        = list(string)
  description = "List of Database Subnet DNS Label"
}

