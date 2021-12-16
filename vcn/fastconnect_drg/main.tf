locals {
  fastconnect_asn_provider_list    = split(",", var.fastconnect_asn_provider_list)
  fastconnect_no_asn_provider_list = split(",", var.fastconnect_no_asn_provider_list)
}

# -----------------------------------------------------------------------------
# Create FastConnect virtual circuit for Azure ExpressRoute
# -----------------------------------------------------------------------------
resource "oci_core_virtual_circuit" "azure_fastconnect_virtual_circuit" {
  count                     = var.use_fastconnect_drg == true && var.fastconnect_provider == "Microsoft Azure" ? 1 : 0
  compartment_id            = var.compartment_ocid
  gateway_id                = var.drg_id
  bandwidth_shape_name      = var.virtual_circuit_bandwidth_shape
  display_name              = "OCI-LZ-VIRTUAL-CIRCUIT"
  provider_service_id       = data.oci_core_fast_connect_provider_service.fast_connect_provider_service.id
  provider_service_key_name = var.provider_service_key_name
  region                    = var.region_key
  routing_policy            = length(var.fastconnect_routing_policy) == 0 ? [""] : var.fastconnect_routing_policy
  type                      = "PRIVATE"
  cross_connect_mappings {
    customer_bgp_peering_ip = var.virtual_circuit_cross_connect_mappings_customer_bgp_peering_ip
    oracle_bgp_peering_ip   = var.virtual_circuit_cross_connect_mappings_oracle_bgp_peering_ip
  }
  cross_connect_mappings {
    customer_bgp_peering_ip = var.virtual_circuit_cross_connect_mappings_customer_secondary_bgp_peering_ip
    oracle_bgp_peering_ip   = var.virtual_circuit_cross_connect_mappings_oracle_secondary_bgp_peering_ip
  }
  freeform_tags             = {
    "Description" = "FastConnect virtual circuit"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create FastConnect virtual circuit for Megaport/QTS/C3ntro/Cologix/CoreSite/Digital Realty/EdgeConneX/Epsilon/Equinix/InterCloud/Lumen/Neutrona/OracleL2ItegDeployment/Zayo
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resource "oci_core_virtual_circuit" "fastconnect_asn_virtual_circuit" {
  count                     = var.use_fastconnect_drg == true && contains(local.fastconnect_asn_provider_list, var.fastconnect_provider) ? 1 : 0
  compartment_id            = var.compartment_ocid
  customer_asn              = var.virtual_circuit_customer_asn
  gateway_id                = var.drg_id
  bandwidth_shape_name      = var.virtual_circuit_bandwidth_shape
  display_name              = "OCI-LZ-VIRTUAL-CIRCUIT"
  provider_service_id       = data.oci_core_fast_connect_provider_service.fast_connect_provider_service.id
  region                    = var.region_key
  routing_policy            = var.fastconnect_routing_policy
  type                      = "PRIVATE"
  cross_connect_mappings {
    customer_bgp_peering_ip = var.virtual_circuit_cross_connect_mappings_customer_bgp_peering_ip
    oracle_bgp_peering_ip   = var.virtual_circuit_cross_connect_mappings_oracle_bgp_peering_ip
  }
  freeform_tags             = {
    "Description" = "FastConnect virtual circuit"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------------------
# Create FastConnect virtual circuit for AT&T/Verizon/BT/OMCS/OracleL3ItegDeployment/Orange
# -----------------------------------------------------------------------------------------
resource "oci_core_virtual_circuit" "fastconnect_no_asn_virtual_circuit" {
  count                     = var.use_fastconnect_drg == true && contains(local.fastconnect_no_asn_provider_list, var.fastconnect_provider) ? 1 : 0
  compartment_id            = var.compartment_ocid
  gateway_id                = var.drg_id
  bandwidth_shape_name      = var.virtual_circuit_bandwidth_shape
  display_name              = "OCI-LZ-VIRTUAL-CIRCUIT"
  provider_service_id       = data.oci_core_fast_connect_provider_service.fast_connect_provider_service.id
  region                    = var.region_key
  routing_policy            = var.fastconnect_routing_policy
  type                      = "PRIVATE"
  freeform_tags             = {
    "Description" = "FastConnect virtual circuit"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}
