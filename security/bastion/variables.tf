# -----------------------------------------------------------------------------
# Bastion Subnet Variables
# -----------------------------------------------------------------------------
variable "network_compartment_id" {
  type        = string
  description = "Network compartment ocid"
}

variable "vcn_id" {
  type        = string
  description = "VCN ocid"
}

variable "bastion_subnet_cidr_block" {
  type        = string
  description = "CIDR Block for bastion subnet"
}

variable "region_key" {
  type        = string
  description = "Region Key"
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
# Bastion Service Variables
# -----------------------------------------------------------------------------
variable "bastion_type" {
  type        = string
  description = "the type of bastion service"
  default     = "standard"
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that bastion is allowed to connect"
}

variable "bastion_max_session_ttl_in_seconds" {
  type        = number
  description = "The maximum amount of time that bastion session can remain active"
  default     = 1800
}
