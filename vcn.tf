# -----------------------------------------------------------------------------
# Create VCN and subnets
# -----------------------------------------------------------------------------
module "vcn_core" {
  source                           = "./vcn/core"
  compartment_ocid                 = module.network-compartment.network_compartment_id
  vcn_cidr_block                   = var.vcn_cidr_block
  vcn_dns_label                    = var.vcn_dns_label
  region_key                       = local.region_key[0]
  workload_compartment_names       = var.workload_compartment_names
  public_subnet_cidr_block         = var.public_subnet_cidr_block
  public_subnet_dns_label          = var.public_subnet_dns_label
  private_subnet_cidr_blocks       = var.private_subnet_cidr_blocks
  private_subnet_dns_labels        = var.private_subnet_dns_labels
  database_subnet_dns_labels       = var.database_subnet_dns_labels
  database_subnet_cidr_blocks      = var.database_subnet_cidr_blocks
  shared_service_subnet_cidr_block = var.shared_service_subnet_cidr_block
  shared_service_subnet_dns_label  = var.shared_service_subnet_dns_label
  tag_geo_location                 = var.tag_geo_location
  tag_cost_center                  = var.tag_cost_center
  ingress_rules_map                = var.ingress_rules_map
  egress_rules_map                 = var.egress_rules_map
  depends_on                       = [module.network-compartment]
}

module "ipsec_drg" {
  compartment_ocid                = module.network-compartment.network_compartment_id
  source                          = "./vcn/ipsec_drg"
  count                           = var.use_ipsec_drg ? 1 : 0
  drg_id                          = module.vcn_core.drg_id
  cpe_ip_address                  = var.cpe_ip_address
  ip_sec_connection_static_routes = var.ip_sec_connection_static_routes
  tag_geo_location                = var.tag_geo_location
  tag_cost_center                 = var.tag_cost_center
}

module "fastconnect_drg" {
  compartment_ocid                                                         = module.network-compartment.network_compartment_id
  region_key                                                               = local.region_key[0]
  source                                                                   = "./vcn/fastconnect_drg"
  count                                                                    = var.use_fastconnect_drg ? 1 : 0
  use_fastconnect_drg                                                      = var.use_fastconnect_drg
  drg_id                                                                   = module.vcn_core.drg_id
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
