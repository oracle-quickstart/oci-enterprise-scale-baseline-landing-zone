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
# IAM Group for Load Balancer Users
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "lb_users_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Load Balancer Users - manage all components in Load-balancing"
  name           = "${var.lb_users_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Load Balancer Users",
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
# IAM Group for Cloud Guard Operator
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "cloud_guard_operators_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Cloud Guard Operators Group"
  name           = "${var.cloud_guard_operators_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Cloud Guard Operators",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group Cloud Guard Analyst
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "cloud_guard_analysts_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Cloud Guard Analysts Group"
  name           = "${var.cloud_guard_analysts_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Cloud Guard Analysts",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Cloud Guard Architect
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "cloud_guard_architects_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Cloud Guard Architects Group"
  name           = "${var.cloud_guard_architects_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Cloud Guard Architects",
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