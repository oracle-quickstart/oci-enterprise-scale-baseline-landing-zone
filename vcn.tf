# -----------------------------------------------------------------------------
# Create VCN and subnets
# -----------------------------------------------------------------------------
module "vcn" {
  source                           = "./vcn"
  compartment_ocid                 = module.network-compartment.network_compartment_id
  cpe_display_name                 = var.cpe_display_name
  cpe_ip_address                   = var.cpe_ip_address
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
