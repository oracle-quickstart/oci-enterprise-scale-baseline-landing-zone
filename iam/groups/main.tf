terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "administrator_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Administrators group - manages all resources"
  name           = "${var.administrator_group_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Administrators",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
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
# IAM Group for Workload Storage Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_storage_admins_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload Specific Storage Administrators Group"
  name           = "${var.workload_storage_admins_group_name}-${each.value}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Workload Storage Administrators",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Workload Storage Users
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_storage_users_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload Storage Users Group"
  name           = "${var.workload_storage_users_group_name}-${each.value}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Workload Storage Users",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Workload Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_admins_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload Users Group"
  name           = "${var.workload_admins_group_name}-${each.value}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Workload Administrators",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Workload Users
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_users_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload Users Group"
  name           = "${var.workload_users_group_name}-${each.value}${var.suffix}"

  freeform_tags = {
    "Description" = "Group for Workload Users",
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
