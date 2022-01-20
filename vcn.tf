locals {
  subnet_list = concat(
    var.is_public_subnet_enabled == true ? [module.public-subnet[0].public-subnet] : [],
    var.is_shared_services_subnet_enabled == true ? [module.fss-subnet[0].fss-subnet] : [],
    module.vcn-core.database_subnet.*,
    module.vcn-core.private_subnet.*
  )

  subnet_map = { for subnet in local.subnet_list : subnet.display_name => subnet.id }
}

# -----------------------------------------------------------------------------
# Create VCN and subnets
# -----------------------------------------------------------------------------
module "vcn-core" {
  source                           = "./vcn/core"
  compartment_ocid                 = module.network-compartment.network_compartment_id
  vcn_cidr_block                   = var.vcn_cidr_block
  vcn_dns_label                    = var.vcn_dns_label
  region_key                       = local.region_key[0]
  workload_compartment_names       = var.workload_compartment_names
  private_subnet_cidr_blocks       = var.private_subnet_cidr_blocks
  private_subnet_dns_labels        = var.private_subnet_dns_labels
  database_subnet_dns_labels       = var.database_subnet_dns_labels
  database_subnet_cidr_blocks      = var.database_subnet_cidr_blocks
  tag_geo_location                 = var.tag_geo_location
  tag_cost_center                  = var.tag_cost_center
  depends_on                       = [module.network-compartment]
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

module "public-subnet" {
  count                            = var.is_public_subnet_enabled == true ? 1 : 0
  source                           = "./vcn/public-subnet"
  compartment_ocid                 = module.network-compartment.network_compartment_id
  vcn_id                           = module.vcn-core.vcn_id
  vcn_cidr_block                   = var.vcn_cidr_block
  internet_gateway_id              = module.vcn-core.internet_gateway_id
  region_key                       = local.region_key[0]
  workload_compartment_names       = var.workload_compartment_names
  public_subnet_cidr_block         = var.public_subnet_cidr_block
  public_subnet_dns_label          = var.public_subnet_dns_label
  tag_geo_location                 = var.tag_geo_location
  tag_cost_center                  = var.tag_cost_center
  ingress_rules_map                = var.ingress_rules_map
  egress_rules_map                 = var.egress_rules_map
  depends_on                       = [module.network-compartment]
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
