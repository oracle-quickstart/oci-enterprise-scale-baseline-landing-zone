# -----------------------------------------------------------------------------
# Create Cloud Guard resources
# -----------------------------------------------------------------------------
module "cloud-guard" {
  source                                                     = "./security/cloud-guard"
  region                                                     = var.region
  activity_detector_recipe_display_name                      = var.activity_detector_recipe_display_name
  cloud_guard_configuration_status                           = var.cloud_guard_configuration_status
  configuration_detector_recipe_display_name                 = var.configuration_detector_recipe_display_name
  host_scan_recipe_agent_settings_agent_configuration_vendor = var.host_scan_recipe_agent_settings_agent_configuration_vendor
  host_scan_recipe_agent_settings_scan_level                 = var.host_scan_recipe_agent_settings_scan_level
  host_scan_recipe_port_settings_scan_level                  = var.host_scan_recipe_port_settings_scan_level
  agent_cis_benchmark_settings_scan_level                    = var.agent_cis_benchmark_settings_scan_level
  vss_scan_schedule                                          = var.vss_scan_schedule
  host_scan_recipe_display_name                              = var.host_scan_recipe_display_name
  host_scan_target_display_name                              = var.host_scan_target_display_name
  host_scan_target_description                               = var.host_scan_target_description
  parent_compartment_ocid                                    = module.parent-compartment.parent_compartment_id
  security_compartment_ocid                                  = module.security-compartment.security_compartment_id
  tenancy_ocid                                               = var.tenancy_ocid
  tag_geo_location                                           = var.tag_geo_location
  tag_cost_center                                            = var.tag_cost_center
  parent_compartment_name                                    = var.parent_compartment_name
  depends_on = [
    module.parent-compartment, module.common-infra-compartment, module.security-compartment
  ]
}

# -----------------------------------------------------------------------------
# Create Bastion resources
# -----------------------------------------------------------------------------
module "bastion" {
  source                               = "./security/bastion"
  vcn_id                               = module.vcn.vcn_id
  tag_geo_location                     = var.tag_geo_location
  tag_cost_center                      = var.tag_cost_center
  bastion_subnet_cidr_block            = var.bastion_subnet_cidr_block
  bastion_type                         = var.bastion_type
  bastion_client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  bastion_max_session_ttl_in_seconds   = var.bastion_max_session_ttl_in_seconds
  network_compartment_id               = module.network-compartment.network_compartment_id
  region_key                           = local.region_key[0]
  depends_on = [
    module.network-compartment
  ]
}

# -----------------------------------------------------------------------------
# Audit Logging
# -----------------------------------------------------------------------------
module "audit" {
  source                              = "./security/audit"
  tenancy_ocid                        = var.tenancy_ocid
  parent_compartment_name             = var.parent_compartment_name
  parent_compartment_ocid             = module.parent-compartment.parent_compartment_id
  security_compartment_name           = var.security_compartment_name
  security_compartment_ocid           = module.security-compartment.security_compartment_id
  retention_rule_duration_time_amount = var.retention_rule_duration_time_amount
  tag_geo_location                    = var.tag_geo_location
  tag_cost_center                     = var.tag_cost_center

  depends_on = [
    module.parent-compartment, module.security-compartment
  ]
}

# -----------------------------------------------------------------------------
# VCN Flow Log
# -----------------------------------------------------------------------------
module "flow-logs" {
  source                    = "./security/flow-logs"
  tenancy_ocid              = var.tenancy_ocid
  security_compartment_ocid = module.security-compartment.security_compartment_id
  security_compartment_name = var.security_compartment_name
  network_compartment_ocid  = module.network-compartment.network_compartment_id
  subnet_map                = module.vcn.subnet_map
  is_flow_log_enabled       = var.is_flow_log_enabled
  tag_geo_location          = var.tag_geo_location
  tag_cost_center           = var.tag_cost_center

  depends_on = [
    module.parent-compartment, module.security-compartment, module.network-compartment
  ]
}
