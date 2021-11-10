# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "administrator_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Administrators group - manages all resources"
  name           = "${var.administrator_group_name}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Network Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "network_admin_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Network Administrators Group - manages all network resources"
  name           = "${var.network_admin_group_name}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Load Balancer Users
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "lb_users_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Load Balancer Users - manage all components in Load-balancing"
  name           = "${var.lb_users_group_name}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Workload Storage Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_storage_admins_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload Specific Storage Administrators"
  name           = "${var.workload_storage_admins_group_name}-${each.value}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Workload Storage Users
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_storage_users_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload Storage User"
  name           = "${var.workload_storage_users_group_name}-${each.value}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Workload Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_admins_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload User Group"
  name           = "${var.workload_admins_group_name}-${each.value}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Workload Users
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_users_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload User"
  name           = "${var.workload_users_group_name}-${each.value}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group Security Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "security_admins_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Security Admin"
  name           = "${var.security_admins_group_name}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Cloud Guard Operator
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "cloud_guard_operators_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone CloudGuard Operators Group"
  name           = "${var.cloud_guard_operators_group_name}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group Cloud Guard Analyst
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "cloud_guard_analysts_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Cloud Guard Analyst"
  name           = "${var.cloud_guard_analysts_group_name}-${var.random_group_name_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group for Cloud Guard Architect
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "cloud_guard_architects_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone CloudGuard Architects Group"
  name           = "${var.cloud_guard_architects_group_name}-${var.random_group_name_id}"
}
