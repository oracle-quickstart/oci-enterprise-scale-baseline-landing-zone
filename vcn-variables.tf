# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Compartment specific variables - Required
# -----------------------------------------------------------------------------
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
}

variable "public_subnet_dns_label" {
  type        = string
  description = "Public Subnet DNS Label"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of Private Subnet CIDR Block (one per workload)"
}

variable "private_subnet_dns_labels" {
  type        = list(string)
  description = "List of Private Subnet DNS Label (one per workload)"
}

variable "database_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of Database Subnet CIDR Block (one per workload)"
}

variable "database_subnet_dns_labels" {
  type        = list(string)
  description = "List of Database Subnet DNS Label (one per workload)"
}

variable "shared_service_subnet_cidr_block" {
  type        = string
  description = "Shared Service Subnet CIDR Block"
}

variable "shared_service_subnet_dns_label" {
  type        = string
  description = "Shared Service Subnet DNS Label"
}

variable "egress_security_rules_stateless" {
  description = "[Workload Security List] Egress Stateless"
  type        = bool
  default     = false
}

variable "egress_security_rules_tcp_options_destination_port_range_max" {
  description = "[Workload Security List] Egress TCP Destination Port Range Max"
  type        = number
}

variable "egress_security_rules_tcp_options_destination_port_range_min" {
  description = "[Workload Security List] Egress TCP Destination Port Range Min"
  type        = number
}

variable "egress_security_rules_tcp_options_source_port_range_max" {
  description = "[Workload Security List] Egress TCP Source Port Range Max"
  type        = number
}

variable "egress_security_rules_tcp_options_source_port_range_min" {
  description = "[Workload Security List] Egress TCP Source Port Range Min"
  type        = number
}

variable "ingress_security_rules_stateless" {
  description = "[Workload Security List]"
  type        = bool
  default     = false
}

variable "ingress_security_rules_tcp_options_destination_port_range_max" {
  description = "[Workload Security List] Ingress TCP Destination Port Range Max"
  type        = number
}

variable "ingress_security_rules_tcp_options_destination_port_range_min" {
  description = "[Workload Security List] Ingress TCP Destination Port Range Min"
  type        = number
}

variable "ingress_security_rules_tcp_options_source_port_range_max" {
  description = "[Workload Security List] Ingress TCP Source Port Range Max"
  type        = number
}

variable "ingress_security_rules_tcp_options_source_port_range_min" {
  description = "[Workload Security List] Ingress TCP Source Port Range Min"
  type        = number
}

variable "ingress_security_rules_description" {
  description = "[Workload Security List] Description"
  type        = string
  default     = "Workload Security List - Ingress"
}
