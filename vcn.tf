locals {
  subnet_list = concat(
    var.is_shared_services_subnet_enabled == true ? [module.fss-subnet[0].fss_subnet] : [],
    module.bastion.bastion_subnet.*,
    [for subnet in data.oci_core_subnet.external_subnets : subnet if subnet.id != null]
  )

  subnet_map = { for subnet in local.subnet_list : subnet.display_name => subnet.id }
}

# -----------------------------------------------------------------------------
# Create VCN and subnets
# -----------------------------------------------------------------------------
module "vcn-core" {
  source           = "./vcn/core"
  compartment_ocid = module.network-compartment.network_compartment_id
  vcn_cidr_block   = var.vcn_cidr_block
  vcn_dns_label    = var.vcn_dns_label
  region_key       = local.region_key[0]
  tag_geo_location = var.tag_geo_location
  tag_cost_center  = var.tag_cost_center
  depends_on       = [module.network-compartment]
}

module "ipsec-drg" {
  compartment_ocid                = module.network-compartment.network_compartment_id
  source                          = "./vcn/ipsec-drg"
  count                           = var.use_ipsec_drg ? 1 : 0
  drg_id                          = module.vcn-core.drg_id
  cpe_ip_address                  = var.cpe_ip_address
  ip_sec_connection_static_routes = var.ip_sec_connection_static_routes
  tag_geo_location                = var.tag_geo_location
  tag_cost_center                 = var.tag_cost_center
}

module "fastconnect-drg" {
  compartment_ocid                                                         = module.network-compartment.network_compartment_id
  region_key                                                               = local.region_key[0]
  source                                                                   = "./vcn/fastconnect-drg"
  count                                                                    = var.use_fastconnect_drg ? 1 : 0
  use_fastconnect_drg                                                      = var.use_fastconnect_drg
  drg_id                                                                   = module.vcn-core.drg_id
  virtual_circuit_bandwidth_shape                                          = format("%s %s", var.virtual_circuit_bandwidth_shape, "Gbps")
  virtual_circuit_cross_connect_mappings_customer_bgp_peering_ip           = var.virtual_circuit_cross_connect_mappings_customer_bgp_peering_ip
  virtual_circuit_cross_connect_mappings_customer_secondary_bgp_peering_ip = var.virtual_circuit_cross_connect_mappings_customer_secondary_bgp_peering_ip
  virtual_circuit_cross_connect_mappings_oracle_bgp_peering_ip             = var.virtual_circuit_cross_connect_mappings_oracle_bgp_peering_ip
  virtual_circuit_cross_connect_mappings_oracle_secondary_bgp_peering_ip   = var.virtual_circuit_cross_connect_mappings_oracle_secondary_bgp_peering_ip
  virtual_circuit_customer_asn                                             = var.virtual_circuit_customer_asn
  fastconnect_provider                                                     = var.fastconnect_provider
  fastconnect_routing_policy                                               = var.fastconnect_routing_policy
  provider_service_key_name                                                = var.provider_service_key_name
  tag_geo_location                                                         = var.tag_geo_location
  tag_cost_center                                                          = var.tag_cost_center
}

module "fss-subnet" {
  count                            = var.is_shared_services_subnet_enabled == true ? 1 : 0
  source                           = "./vcn/fss-subnet"
  compartment_ocid                 = module.network-compartment.network_compartment_id
  vcn_id                           = module.vcn-core.vcn_id
  shared_service_subnet_cidr_block = var.shared_service_subnet_cidr_block
  shared_service_subnet_dns_label  = var.shared_service_subnet_dns_label
  tag_geo_location                 = var.tag_geo_location
  tag_cost_center                  = var.tag_cost_center
  depends_on                       = [module.network-compartment]
}
