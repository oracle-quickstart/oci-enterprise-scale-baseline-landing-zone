terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Network Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "network_admin_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Network Administrators Group - manages all network resources"
  name           = "${var.network_admin_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Network Administrators",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group Security Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "security_admins_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Security Administrators Group"
  name           = "${var.security_admins_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Security Administrators",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for IAM Admin 
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "iam_admin_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone IAM Group"
  name           = "${var.iam_admin_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for IAM Admin",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM group for Platform admin 
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "platform_admin_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Platform Admin Group"
  name           = "${var.platform_admin_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Platform Admin",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM group for Ops admin 
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "ops_admin_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Ops Admin Group"
  name           = "${var.ops_admin_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Ops Admin",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}