# ---------------------------------------------------------------------------------------------------------------------
#  Outputs for Administrators (Group Name and OCID)
# ---------------------------------------------------------------------------------------------------------------------
output "administrator_group_name" {
  value = oci_identity_group.administrator_group.name
}

output "administrator_group_id" {
  value = oci_identity_group.administrator_group.id
}

# ---------------------------------------------------------------------------------------------------------------------
# Output for Network Administrators (Group Name)
# ---------------------------------------------------------------------------------------------------------------------
output "network_admin_group_name" {
  value = oci_identity_group.network_admin_group.name
}

# ---------------------------------------------------------------------------------------------------------------------
# Output for Load Balancer Users (Group name)
# ---------------------------------------------------------------------------------------------------------------------
output "lb_users_group_name" {
  value = oci_identity_group.lb_users_group.name
}

# ---------------------------------------------------------------------------------------------------------------------
# Output for Workload Storage Administrators (Group Names)
# ---------------------------------------------------------------------------------------------------------------------
output "workload_storage_admins_group_names" {
  value = oci_identity_group.workload_storage_admins_group
}

# ---------------------------------------------------------------------------------------------------------------------
# Output for Workload Storage Users (Group Names)
# ---------------------------------------------------------------------------------------------------------------------
output "workload_storage_users_group_names" {
  value = oci_identity_group.workload_storage_users_group
}

# ---------------------------------------------------------------------------------------------------------------------
# Output for Workload Administrators (Group Names)
# ---------------------------------------------------------------------------------------------------------------------
output "workload_admins_group_names" {
  value = oci_identity_group.workload_admins_group
}

# ---------------------------------------------------------------------------------------------------------------------
# Output for Workload Users (Group Names)
# ---------------------------------------------------------------------------------------------------------------------
output "workload_users_group_names" {
  value = oci_identity_group.workload_users_group
}

# ---------------------------------------------------------------------------------------------------------------------
# Output for Cloud Guard Operator (Group Name)
# ---------------------------------------------------------------------------------------------------------------------
output "cloud_guard_operators_group_name" {
  value = oci_identity_group.cloud_guard_operators_group.name
}

# ---------------------------------------------------------------------------------------------------------------------
# Output for Cloud Guard Architect (Group Name)
# ---------------------------------------------------------------------------------------------------------------------
output "cloud_guard_architects_group_name" {
  value = oci_identity_group.cloud_guard_architects_group.name
}