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
# Public Subnet Inputs
# -----------------------------------------------------------------------------
variable "public_subnet_cidr_block" {
  type        = string
  description = "Public Subnet CIDR Block"
}

variable "public_subnet_dns_label" {
  type        = string
  description = "Public Subnet DNS Label"
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

# -----------------------------------------------------------------------------
# Shared Service Subnet Inputs
# -----------------------------------------------------------------------------
variable "shared_service_subnet_cidr_block" {
  type        = string
  description = "Shared Service Subnet CIDR Block"
}

variable "shared_service_subnet_dns_label" {
  type        = string
  description = "Shared Service Subnet DNS Label"
}

# -----------------------------------------------------------------------------
# Security List Egress Inputs
# -----------------------------------------------------------------------------
variable "egress_security_rules_description" {
  description = "[Workload Security List] Description"
  type        = string
  default     = "Workload Security List - Egress"
}

variable "egress_security_rules_protocol" {
  description = "[Workload Security List] Egress Protocol"
  type        = string
  default     = "6"
}

variable "egress_security_rules_stateless" {
  description = "[Workload Security List] Egress Stateless"
  type        = bool
  default     = false
}

variable "egress_rules_map" {
  description = "[Workload Security List] Egress Rules Map"
  type = map(object({
    egress_security_rules_tcp_options_destination_port_range_max = string
    egress_security_rules_tcp_options_destination_port_range_min = string
    egress_security_rules_tcp_options_source_port_range_max      = string
    egress_security_rules_tcp_options_source_port_range_min      = string
  }))
}

# -----------------------------------------------------------------------------
# Security List Ingress Inputs
# -----------------------------------------------------------------------------
variable "ingress_security_rules_description" {
  description = "[Workload Security List] Description"
  type        = string
  default     = "Workload Security List - Ingress"
}

variable "ingress_security_rules_protocol" {
  description = "[Workload Security List] Ingress Protocol"
  type        = string
  default     = "6"
}

variable "ingress_security_rules_stateless" {
  description = "[Workload Security List]"
  type        = bool
  default     = false
}

variable "ingress_rules_map" {
  description = "[Workload Security List] Ingress Rules Map"
  type = map(object({
    ingress_security_rules_tcp_options_destination_port_range_max = string
    ingress_security_rules_tcp_options_destination_port_range_min = string
    ingress_security_rules_tcp_options_source_port_range_max      = string
    ingress_security_rules_tcp_options_source_port_range_min      = string
  }))
}

# -----------------------------------------------------------------------------
# Dynamic Resource Group Inputs
# -----------------------------------------------------------------------------
variable "cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment IP address"
}

variable "ip_sec_connection_static_routes" {
  type        = list(string)
  description = "IPSec connection static routes"
}
