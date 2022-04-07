terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci, oci.home_region]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Vulnerability scanning service polices for each cloud guard target
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "vulnerability_scanning_service_policy" {
  provider       = oci.home_region
  compartment_id = var.parent_compartment_ocid
  description    = "OCI Landing Zone Scanning-service Policy"
  name           = "${var.vulnerability_scanning_service_policy_name}${var.suffix}"

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
