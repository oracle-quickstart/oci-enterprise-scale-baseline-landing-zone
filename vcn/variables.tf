variable "compartment_ocid" {
  type        = string
  description = "Network compartment ocid"
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

variable "private_subnet_cidr_block" {
  type        = string
  description = "Private Subnet CIDR Block"
}

variable "private_subnet_dns_label" {
  type        = string
  description = "Private Subnet DNS Label"
}

variable "database_subnet_cidr_block" {
  type        = string
  description = "Database Subnet CIDR Block"
}

variable "database_subnet_dns_label" {
  type        = string
  description = "Database Subnet DNS Label"
}

variable "shared_service_subnet_cidr_block" {
  type        = string
  description = "Shared Service Subnet CIDR Block"
}

variable "shared_service_subnet_dns_label" {
  type        = string
  description = "Shared Service Subnet DNS Label"
}