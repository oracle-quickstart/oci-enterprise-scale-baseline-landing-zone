variable "compartment_ocid" {
  type        = string
  description = "Network compartment ocid"
}

variable "drg_id" {
  type        = string
  description = "The DRG OCID from the VCN"
}

variable "cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment IP address"
}

variable "ip_sec_connection_static_routes" {
  type        = list(string)
  description = "IPSec connection static routes"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}