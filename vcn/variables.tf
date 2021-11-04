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

variable "vcn_cidr_block" {
  type        = string
  description = "Primary VCN CIDR Block"
}

variable "vcn_dns_label" {
  type        = string
  description = "VCN DNS Label"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "Public Subnet CIDR Block"
}

variable "public_subnet_dns_label" {
  type        = string
  description = "Public Subnet DNS Label"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of Private Subnet CIDR Block"
}

variable "private_subnet_dns_labels" {
  type        = list(string)
  description = "List of Private Subnet DNS Label"
}

variable "database_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of Database Subnet CIDR Block"
}

variable "database_subnet_dns_labels" {
  type        = list(string)
  description = "List of Database Subnet DNS Label"
}

variable "shared_service_subnet_cidr_block" {
  type        = string
  description = "Shared Service Subnet CIDR Block"
}

variable "shared_service_subnet_dns_label" {
  type        = string
  description = "Shared Service Subnet DNS Label"
}
