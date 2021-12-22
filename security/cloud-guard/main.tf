terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci, oci.home_region]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Random IDs to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
resource "random_id" "policy_name" {
  byte_length = 8
}

resource "random_id" "target_name" {
  byte_length = 8
}

resource "oci_cloud_guard_cloud_guard_configuration" "tenancy_cloud_guard_configuration" {
  compartment_id   = var.tenancy_ocid
  reporting_region = var.region
  status           = var.is_cloud_guard_enabled == true ? "ENABLED" : "DISABLED"
}

# ---------------------------------------------------------------------------------------------------------------------
# Cloud Guard policies
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "cloud_guard_policy" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Cloud Guard Policy"
  name           = "${var.cloud_guard_policy_name}-${random_id.policy_name.id}"

  freeform_tags = {
    "Description" = "Cloud guard policy"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    "Allow service cloudguard to read keys in tenancy",
    "Allow service cloudguard to read compartments in tenancy",
    "Allow service cloudguard to read compute-management-family in tenancy",
    "Allow service cloudguard to read instance-family in tenancy",
    "Allow service cloudguard to read virtual-network-family in tenancy",
    "Allow service cloudguard to read volume-family in tenancy",
    "Allow service cloudguard to read tenancies in tenancy",
    "Allow service cloudguard to read audit-events in tenancy",
    "Allow service cloudguard to read vaults in tenancy",
    "Allow service cloudguard to read object-family in tenancy",
    "Allow service cloudguard to read load-balancers in tenancy",
    "Allow service cloudguard to read object-family in tenancy",
    "Allow service cloudguard to read groups in tenancy",
    "Allow service cloudguard to read dynamic-groups in tenancy",
    "Allow service cloudguard to read users in tenancy",
    "Allow service cloudguard to read database-family in tenancy",
    "Allow service cloudguard to read authentication-policies in tenancy",
    "Allow service cloudguard to read policies in tenancy"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Cloud Guard target
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_cloud_guard_target" "cloud_guard_target" {
  count                = var.is_cloud_guard_enabled == true ? 1 : 0
  compartment_id       = var.parent_compartment_ocid
  display_name         = "${var.cloud_guard_target_name}-${random_id.target_name.id}"
  target_resource_id   = var.parent_compartment_ocid
  target_resource_type = var.target_resource_type
  description          = var.target_description

  freeform_tags = {
    "Description" = "Cloud guard target"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  target_detector_recipes {
    detector_recipe_id = data.oci_cloud_guard_detector_recipes.configuration_detector_recipe.detector_recipe_collection.0.items.0.id
  }

  target_detector_recipes {
    detector_recipe_id = data.oci_cloud_guard_detector_recipes.activity_detector_recipe.detector_recipe_collection.0.items.0.id
  }

  depends_on = [oci_cloud_guard_cloud_guard_configuration.tenancy_cloud_guard_configuration]
}

# ---------------------------------------------------------------------------------------------------------------------
# Vulnerability scanning service polices for each cloud guard target
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "vulnerability_scanning_service_policy" {
  provider       = oci.home_region
  compartment_id = var.parent_compartment_ocid
  description    = "OCI Landing Zone Scanning-service Policy"
  name           = "${var.vulnerability_scanning_service_policy_name}-${random_id.policy_name.id}"

  freeform_tags = {
    "Description" = "Vulnerability Scanning Service Policy"
    "CostCenter"  = var.tag_cost_center
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    "Allow service vulnerability-scanning-service to manage instances in compartment ${var.parent_compartment_name}",
    "Allow service vulnerability-scanning-service to read compartments in compartment ${var.parent_compartment_name}",
    "Allow service vulnerability-scanning-service to read vnics in compartment ${var.parent_compartment_name}",
    "Allow service vulnerability-scanning-service to read vnic-attachments in compartment ${var.parent_compartment_name}",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Vulnerability scanning service host scan recipe
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_vulnerability_scanning_host_scan_recipe" "vss_host_scan_recipe" {
  compartment_id = var.security_compartment_ocid
  display_name   = var.host_scan_recipe_display_name

  agent_settings {
    scan_level = var.host_scan_recipe_agent_settings_scan_level

    agent_configuration {
      vendor = var.host_scan_recipe_agent_settings_agent_configuration_vendor
      cis_benchmark_settings {
        scan_level = var.agent_cis_benchmark_settings_scan_level
      }
    }
  }

  port_settings {
    scan_level = var.host_scan_recipe_port_settings_scan_level
  }

  schedule {
    type = var.vss_scan_schedule
  }

  freeform_tags = {
    "Description" = "Vulnerability Scanning Service Host Scan Recipe"
    "CostCenter"  = var.tag_cost_center
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Vulnerability scanning service target
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_vulnerability_scanning_host_scan_target" "vss_host_scan_target" {
  compartment_id        = var.security_compartment_ocid
  host_scan_recipe_id   = oci_vulnerability_scanning_host_scan_recipe.vss_host_scan_recipe.id
  target_compartment_id = var.parent_compartment_ocid

  description  = var.host_scan_target_description
  display_name = var.host_scan_target_display_name

  freeform_tags = {
    "Description" = "Vulnerability Scanning Service Host Scan Target"
    "CostCenter"  = var.tag_cost_center
    "GeoLocation" = var.tag_geo_location
  }
}
