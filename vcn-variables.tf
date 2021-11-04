variable "vcn_cidr_block" {
  type        = string
  description = "Primary VCN CIDR Block"
  default     = "10.0.0.0/16"
}

variable "vcn_dns_label" {
  type        = string
  description = "VCN DNS Label"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "Public Subnet CIDR Block"
  default     = "10.0.1.0/16"
}

variable "public_subnet_dns_label" {
  type        = string
  description = "Public Subnet DNS Label"
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "Private Subnet CIDR Block"
  default     = "10.0.2.0/16"
}

variable "private_subnet_dns_label" {
  type        = string
  description = "Private Subnet DNS Label"
}

variable "database_subnet_cidr_block" {
  type        = string
  description = "Database Subnet CIDR Block"
  default     = "10.0.3.0/16"
}

variable "database_subnet_dns_label" {
  type        = string
  description = "Database Subnet DNS Label"
}

variable "shared_service_subnet_cidr_block" {
  type        = string
  description = "Shared Service Subnet CIDR Block"
  default     = "10.0.4.0/16"
}

variable "shared_service_subnet_dns_label" {
  type        = string
  description = "Shared Service Subnet DNS Label"
}