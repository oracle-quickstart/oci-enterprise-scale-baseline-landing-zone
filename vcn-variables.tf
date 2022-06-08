# -----------------------------------------------------------------------------
# VCN Variables
# -----------------------------------------------------------------------------
variable "vcn_cidr_block" {
  type        = string
  description = "Primary VCN CIDR Block"
  default     = "10.0.0.0/16"
  validation {
    condition     = can(regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1][0-9]|[2][0-9]))$", var.vcn_cidr_block))
    error_message = "Must be a valid address range in CIDR notation."
  }
}

variable "vcn_dns_label" {
  type        = string
  description = "VCN DNS Label"
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9]{1,14}$", var.vcn_dns_label))
    error_message = "Allowed maximum 15 alphanumeric characters and must start with a letter."
  }
}

# -----------------------------------------------------------------------------
# Subnet Variables
# -----------------------------------------------------------------------------
variable "shared_service_subnet_cidr_block" {
  type        = string
  description = "Shared Service Subnet CIDR Block"
  default     = ""
  validation {
    condition     = can(regex("^$|^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1][0-9]|[2][0-9]))$", var.shared_service_subnet_cidr_block))
    error_message = "Must be a valid address range in CIDR notation."
  }
}

variable "shared_service_subnet_dns_label" {
  type        = string
  description = "Shared Service Subnet DNS Label"
  default     = ""
  validation {
    condition     = can(regex("^$|^[a-zA-Z][a-zA-Z0-9]{1,14}$", var.shared_service_subnet_dns_label))
    error_message = "Allowed maximum 15 alphanumeric characters and must start with a letter."
  }
}

# -----------------------------------------------------------------------------
# Dynamic Routing Gateway Inputs
# -----------------------------------------------------------------------------
variable "use_ipsec_drg" {
  type        = bool
  description = "Do you want to deploy the ipsec connectivity option? (true/false)"
  default     = false
}

variable "cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment IP address"
  default     = ""
}

variable "ip_sec_connection_static_routes" {
  type        = list(string)
  description = "IPSec connection static routes"
  default     = []
}

variable "use_fastconnect_drg" {
  type        = bool
  description = "Do you want to deploy the fastconnect connectivity option? (true/false)"
  default     = false
}

variable "virtual_circuit_bandwidth_shape" {
  type        = string
  description = "The provisioned data rate of the connection"
  default     = ""
}

variable "provider_service_key_name" {
  type        = string
  description = "The provider service key that the provider gives you when you set up a virtual circuit connection from the provider to OCI"
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
  type        = number
  description = "The BGP ASN of the network at the other end of the BGP session from Oracle"
  default     = 0
}

variable "fastconnect_routing_policy" {
  type        = list(string)
  description = "Available FastConnect routing policies: ORACLE_SERVICE_NETWORK, REGIONAL, MARKET_LEVEL, GLOBAL"
  default     = []
}

variable "external_subnet_ocids" {
  type        = list(string)
  description = "OCIDs of subnets created outside of this stack to be tracked in the VCN Flow Log service"
  default     = []
}
