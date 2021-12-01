# ---------------------------------------------------------------------------------------------------------------------
# Random IDs to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
resource "random_id" "bastion_name" {
  byte_length = 4 
}

# ---------------------------------------------------------------------------------------------------------------------
# Bastion subnet and resources
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_core_subnet" "bastion_subnet" {
  cidr_block     = var.bastion_subnet_cidr_block
  compartment_id = var.network_compartment_id
  vcn_id         = var.vcn_id
  display_name   = "OCI-LZ-Bastion-${var.region_key}-subnet"

  freeform_tags = {
    "Description" = "Bastion Subnet"
    "CostCenter"  = var.tag_cost_center
    "GeoLocation" = var.tag_geo_location
  }
}

resource "oci_bastion_bastion" "bastion" {
  bastion_type                 = var.bastion_type
  compartment_id               = var.network_compartment_id
  target_subnet_id             = oci_core_subnet.bastion_subnet.id
  client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  max_session_ttl_in_seconds   = var.bastion_max_session_ttl_in_seconds
  name                         = "LZBastion${random_id.bastion_name.id}"

  freeform_tags = {
    "Description" = "Bastion Service"
    "CostCenter"  = var.tag_cost_center
    "GeoLocation" = var.tag_geo_location
  }
}
