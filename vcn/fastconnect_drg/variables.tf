# -----------------------------------------------------------------------------
# Fastconnect Inputs
# -----------------------------------------------------------------------------
variable "compartment_ocid" {
  type        = string
  description = "Network compartment ocid"
}

variable "region_key" {
  type        = string
  description = "Region Key"
}

variable "drg_id" {
  type        = string
  description = "The DRG OCID from the VCN"
}

variable "virtual_circuit_bandwidth_shape" {
  type        = string
  description = "The provisioned data rate of the connection"
}

variable "provider_service_key_name" {
  type        = string
  description = "The provider service key that the provider gives you when you set up a virtual circuit connection from the provider to OCI"
}

variable "virtual_circuit_cross_connect_mappings_customer_bgp_peering_ip" {
  type = string
  description = "This is the BGP IPv4 address of the customer's router"
}

variable "virtual_circuit_cross_connect_mappings_oracle_bgp_peering_ip" {
  type = string
  description= "IPv4 address for Oracle's end of the BGP session"
}

variable "virtual_circuit_cross_connect_mappings_customer_secondary_bgp_peering_ip" {
  type = string
  description = "This is the secondary BGP IPv4 address of the customer's router"
}

variable "virtual_circuit_cross_connect_mappings_oracle_secondary_bgp_peering_ip" {
  type = string
  description= "Secondary IPv4 address for Oracle's end of the BGP session"
}

variable "fastconnect_provider" {
  type        = string
  description = "Available FastConnect providers: AT&T, Microsoft Azure, Megaport, QTS, CEintro, Cologix, CoreSite, Digitial Realty, EdgeConneX, Epsilon, Equinix, InterCloud, Lumen, Neutrona, OMCS, OracleL2ItegDeployment, OracleL3ItegDeployment, Orange, Verizon, Zayo"
}

variable "virtual_circuit_customer_asn" {
  type        = number
  description = "FastConnect customer ASN"
}

variable "fastconnect_asn_provider_list" {
  type        = string
  description = "Providers that require customer asn"
  default     = "Megaport,QTS,C3ntro,Cologix,CoreSite,Digital Realty,EdgeConneX,Epsilon,Equinix,InterCloud,Lumen,Neutrona,OracleL2ItegDeployment,Zayo"
}

variable "fastconnect_no_asn_provider_list" {
  type        = string
  description = "Providers that don't require customer asn or peering ip"
  default     = "AT&T,Verizon,BT,OMCS,OracleL3ItegDeployment,Orange"
}

variable "fastconnect_routing_policy" {
  type        = list(string)
  description = "FastConnect virtual circuit routing policy"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}