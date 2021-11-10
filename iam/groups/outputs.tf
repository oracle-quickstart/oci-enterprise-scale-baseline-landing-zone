output "administrator_group_name" {
  value = oci_identity_group.administrator_group.name
}

output "administrator_group_id" {
  value = oci_identity_group.administrator_group.id
}

output "network_admin_group_name" {
  value = oci_identity_group.network_admin_group.name
}

output "lb_users_group_name" {
  value = oci_identity_group.lb_users_group.name
}

output "workload_storage_admins_group_names" {
  value = oci_identity_group.workload_storage_admins_group
}

output "workload_storage_users_group_names" {
  value = oci_identity_group.workload_storage_users_group
}

output "workload_admins_group_names" {
  value = oci_identity_group.workload_admins_group
}

output "workload_users_group_names" {
  value = oci_identity_group.workload_users_group
}
