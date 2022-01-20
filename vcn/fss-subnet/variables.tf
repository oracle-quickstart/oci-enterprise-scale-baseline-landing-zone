# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "compartment_ocid" {
  type        = string
  description = "Network compartment ocid"
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
# VCN Inputs
# -----------------------------------------------------------------------------
variable "vcn_id" {
  type        = string
  description = "The OCID of the VCN"
}

