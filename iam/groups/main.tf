# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "administrator_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Administrators group - manages all resources"
  name           = "${var.administrator_group_name}-${var.random_group_name_id}"

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
  name           = "${var.network_admin_group_name}-${var.random_group_name_id}"

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
  name           = "${var.lb_users_group_name}-${var.random_group_name_id}"

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
  description    = "OCI Landing Zone Workload Specific Storage Administrators"
  name           = "${var.workload_storage_admins_group_name}-${each.value}-${var.random_group_name_id}"

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
  description    = "OCI Landing Zone Workload Storage User"
  name           = "${var.workload_storage_users_group_name}-${each.value}-${var.random_group_name_id}"

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
  description    = "OCI Landing Zone Workload User Group"
  name           = "${var.workload_admins_group_name}-${each.value}-${var.random_group_name_id}"

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
  description    = "OCI Landing Zone Workload User"
  name           = "${var.workload_users_group_name}-${each.value}-${var.random_group_name_id}"

  freeform_tags = {
    "Description" = "Group for Workload Users",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

