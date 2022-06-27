# -----------------------------------------------------------------------------
# Create Cloud Guard resources
# -----------------------------------------------------------------------------
module "cloud-guard" {
  source                                     = "./security/cloud-guard"
  count                                      = var.deploy_global_resources ? 1 : 0
  region                                     = local.home_region[0]
  is_cloud_guard_enabled                     = var.is_cloud_guard_enabled
  parent_compartment_ocid                    = module.parent-compartment.parent_compartment_id
  security_compartment_ocid                  = module.security-compartment.security_compartment_id
  tenancy_ocid                               = var.tenancy_ocid
  tag_geo_location                           = var.tag_geo_location
  tag_cost_center                            = var.tag_cost_center
  parent_compartment_name                    = module.parent-compartment.parent_compartment_name
  suffix                                     = var.is_sandbox_mode_enabled == true ? "-${random_id.suffix.hex}" : ""

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

  depends_on = [
    module.parent-compartment, module.common-infra-compartment, module.security-compartment
  ]
}

module "vss" {
  source                                     = "./security/vss"
  count                                      = var.deploy_global_resources && var.is_vulnerability_scanning_service_enabled ? 1 : 0
  host_scan_recipe_agent_settings_scan_level = var.host_scan_recipe_agent_settings_scan_level
  host_scan_recipe_port_settings_scan_level  = var.host_scan_recipe_port_settings_scan_level
  agent_cis_benchmark_settings_scan_level    = var.agent_cis_benchmark_settings_scan_level
  vss_scan_schedule                          = var.vss_scan_schedule
  parent_compartment_ocid                    = module.parent-compartment.parent_compartment_id
  security_compartment_ocid                  = module.security-compartment.security_compartment_id
  tenancy_ocid                               = var.tenancy_ocid
  tag_geo_location                           = var.tag_geo_location
  tag_cost_center                            = var.tag_cost_center
  parent_compartment_name                    = module.parent-compartment.parent_compartment_name
  suffix                                     = var.is_sandbox_mode_enabled == true ? "-${random_id.suffix.hex}" : ""

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

  depends_on = [
    module.parent-compartment, module.common-infra-compartment, module.security-compartment
  ]
}

# -----------------------------------------------------------------------------
# Create Bastion resources
# -----------------------------------------------------------------------------
module "bastion" {
  source                               = "./security/bastion"
  count                                = var.enable_bastion && !var.is_sandbox_mode_enabled ? 1 : 0
  vcn_id                               = module.vcn-core.vcn_id
  tag_geo_location                     = var.tag_geo_location
  tag_cost_center                      = var.tag_cost_center
  bastion_subnet_cidr_block            = var.bastion_subnet_cidr_block
  bastion_client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  network_compartment_id               = module.network-compartment.network_compartment_id
  region_key                           = local.region_key[0]
  suffix                               = var.is_sandbox_mode_enabled == true ? random_id.suffix.hex : ""

  depends_on = [
    module.network-compartment
  ]
}

# -----------------------------------------------------------------------------
# Audit Logging
# -----------------------------------------------------------------------------
module "audit" {
  source                              = "./security/audit"
  count                               = var.deploy_global_resources && (var.advanced_logging_option == "AUDIT_LOGS" || var.advanced_logging_option == "BOTH")  ? 1 : 0
  tenancy_ocid                        = var.tenancy_ocid
  parent_compartment_name             = module.parent-compartment.parent_compartment_name
  parent_compartment_ocid             = module.parent-compartment.parent_compartment_id
  security_compartment_name           = var.security_compartment_name
  security_compartment_ocid           = module.security-compartment.security_compartment_id
  retention_rule_duration_time_amount = var.retention_rule_duration_time_amount
  tag_geo_location                    = var.tag_geo_location
  tag_cost_center                     = var.tag_cost_center
  suffix                              = var.is_sandbox_mode_enabled == true ? "-${random_id.suffix.hex}" : ""
  key_id                              = module.key.key_id
  is_sandbox_mode_enabled             = var.is_sandbox_mode_enabled
  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

  depends_on = [
    module.parent-compartment, module.security-compartment, module.key
  ]
}

# -----------------------------------------------------------------------------
# VCN Flow Log
# -----------------------------------------------------------------------------
module "flow-logs" {
  source                    = "./security/flow-logs"
  count                     = var.deploy_global_resources && (var.advanced_logging_option == "FLOW_LOGS" || var.advanced_logging_option == "BOTH")  ? 1 : 0
  tenancy_ocid              = var.tenancy_ocid
  security_compartment_ocid = module.security-compartment.security_compartment_id
  security_compartment_name = var.security_compartment_name
  network_compartment_ocid  = module.network-compartment.network_compartment_id
  subnet_map                = local.subnet_map
  tag_geo_location          = var.tag_geo_location
  tag_cost_center           = var.tag_cost_center
  suffix                    = var.is_sandbox_mode_enabled == true ? "-${random_id.suffix.hex}" : ""

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

  depends_on = [
    module.parent-compartment, module.security-compartment, module.network-compartment
  ]
}


# -----------------------------------------------------------------------------
# Vault and Key
# -----------------------------------------------------------------------------
module "vault" {
  source                    = "./security/vault"
  security_compartment_ocid = module.security-compartment.security_compartment_id
  tag_cost_center           = var.tag_cost_center
  tag_geo_location          = var.tag_geo_location

  depends_on = [
    module.security-compartment
  ]
}

module "key" {
  source                    = "./security/key"
  security_compartment_ocid = module.security-compartment.security_compartment_id
  tag_cost_center           = var.tag_cost_center
  tag_geo_location          = var.tag_geo_location
  key_management_endpoint   = module.vault.key_management_endpoint

  depends_on = [
    module.security-compartment, module.vault
  ]
}