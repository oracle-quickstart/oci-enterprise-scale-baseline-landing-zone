# -----------------------------------------------------------------------------
# VCN Variables
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

# -----------------------------------------------------------------------------
# Subnet Variables
# -----------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------
# Security List Variables
# -----------------------------------------------------------------------------
variable "egress_rules_map" {
  description = "[Workload Security List] Egress Rules Map"
  type = map(object({
    egress_security_rules_tcp_options_destination_port_range_max = number
    egress_security_rules_tcp_options_destination_port_range_min = number
    egress_security_rules_tcp_options_source_port_range_max      = number
    egress_security_rules_tcp_options_source_port_range_min      = number
  }))
  default = {}
}

variable "ingress_rules_map" {
  description = "[Workload Security List] Ingress Rules Map"
  type = map(object({
    ingress_security_rules_tcp_options_destination_port_range_max = number
    ingress_security_rules_tcp_options_destination_port_range_min = number
    ingress_security_rules_tcp_options_source_port_range_max      = number
    ingress_security_rules_tcp_options_source_port_range_min      = number
  }))
  default = {}
}

# -----------------------------------------------------------------------------
# Dynamic Routing Gateway Inputs
# -----------------------------------------------------------------------------
variable "ipsec_connectivity_option" {
  type = string
  description = "Do you want to deploy the ipsec connectivity option? (yes/no)"
  validation {
    condition     = var.ipsec_connectivity_option == "yes" || var.ipsec_connectivity_option == "no"
    error_message = "Please enter yes or no for deploying IPSec tunnel resources."
  }
}

variable "cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment IP address"
  default     = ""
}

variable "ip_sec_connection_static_routes" {
  type        = list(string)
  description = "IPSec connection static routes"
  default     = [""]
}

variable "fastconnect_connectivity_option" {
  type        = string
  description = "Do you want to deploy the fastconnect connectivity option? (yes/no)"
  validation {
    condition     = var.fastconnect_connectivity_option == "yes" || var.fastconnect_connectivity_option == "no"
    error_message = "Please enter yes or no for deploying FastConnect resources."
  }
}

variable "virtual_circuit_bandwidth_shape" {
  type        = string
  description = "Virtual Circuit bandwidth shape name"
  default     = ""
}

variable "provider_service_key_name" {
  type        = string
  description = "Virtual Circuit provider service key"
  default     = ""
}

variable "virtual_circuit_cross_connect_mappings_customer_bgp_peering_ip" {
  type        = string
  description = "This is the BGP IPv4 address of the customer's router"
  default     = ""
}

variable "virtual_circuit_cross_connect_mappings_oracle_bgp_peering_ip" {
  type        = string
  description = "IPv4 address for Oracle's end of the BGP session"
  default     = ""
}

variable "virtual_circuit_cross_connect_mappings_customer_secondary_bgp_peering_ip" {
  type        = string
  description = "This is the secondary BGP IPv4 address of the customer's router"
  default     = ""
}

variable "virtual_circuit_cross_connect_mappings_oracle_secondary_bgp_peering_ip" {
  type        = string
  description = "Secondary IPv4 address for Oracle's end of the BGP session"
  default     = ""
}

variable "fastconnect_provider" {
  type        = string
  description = "Available FastConnect providers: AT&T, Microsoft Azure, Megaport, QTS, CEintro, Cologix, CoreSite, Digitial Realty, EdgeConneX, Epsilon, Equinix, InterCloud, Lumen, Neutrona, OMCS, OracleL2ItegDeployment, OracleL3ItegDeployment, Orange, Verizon, Zayo"
  default     = ""
}

variable "virtual_circuit_customer_asn" {
  type        = string
  description = "FastConnect customer BGP ASN"
  default     = "0"
}
