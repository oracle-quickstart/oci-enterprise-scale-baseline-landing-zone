# ---------------------------------------------------------------------------------------------------------------------
# Random IDs to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
resource "random_id" "policy_name" {
  byte_length = 8
}

resource "random_id" "group_name" {
  byte_length = 8
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies for Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "administrator_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Administrators group - manages all resources"
  name           = "${var.administrator_group_name}-${random_id.group_name.id}"
}

resource "oci_identity_policy" "administrator_policies" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Administrator Tenancy Policy"
  name           = "${var.administrator_policy_name}-${random_id.policy_name.id}"
  freeform_tags = {
    "Description" = "Policy for access to all resources in tenancy"
  }
  statements = [
    "Allow group ${oci_identity_group.administrator_group.name} to manage all-resources in tenancy where request.user.mfaTotpVerified='true'"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies Network Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "network_admin_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Network Administrators Group - manages all network resources"
  name           = "${var.network_admin_group_name}-${random_id.group_name.id}"
}

resource "oci_identity_policy" "network_admin_policies" {
  compartment_id = var.network_compartment_id
  description    = "OCI Landing Zone VCN Administrator Policy"
  name           = var.network_admin_policy_name
  freeform_tags = {
    "Description" = "Policy for access to all network resources in Network Compartment"
  }
  statements = [
    "Allow group ${oci_identity_group.network_admin_group.name} to manage virtual-network-family in compartment ${var.network_compartment_name}"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies LB Users
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "lb_users_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Load Balancer Users - manage all components in Load-balancing"
  name           = "${var.lb_users_group_name}-${random_id.group_name.id}"
}

resource "oci_identity_policy" "lb_users_policies" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.network_compartment_id
  description    = "OCI Landing Zone Load Balancer User Policy"
  name           = "OCI-LZ-${each.value}-LBUserPolicy"
  freeform_tags = {
    "Description" = "Policy for access to all components in Load-balancing and use network family in Network compartment"
  }
  statements = [
    "Allow group ${oci_identity_group.lb_users_group.name} to use virtual-network-family in compartment ${var.network_compartment_name}",
    "Allow group ${oci_identity_group.lb_users_group.name} to manage load-balancers in compartment ${var.network_compartment_name}"

  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies Workload-Storage-Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_storage_admins_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload Specific Storage Administrators"
  name           = "${var.workload_storage_admins_group_name}-${each.value}-${random_id.group_name.id}"
}

resource "oci_identity_policy" "workload_storage_admins_policies" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.workload_compartment_ocids[each.value]
  description    = "OCI Landing Zone Workload Specific Storage Administrator Policies"
  name           = "OCI-LZ-${each.value}-StorageAdminPolicy"
  freeform_tags = {
    "Description" = "Policy for Workload Specific Storage Administrator"
  }
  statements = [
    "Allow group ${var.workload_storage_admins_group_name}-${each.value}-${random_id.group_name.id} to manage volumes in
    compartment ${each.value}",
    "Allow group ${var.workload_storage_admins_group_name}-${each.value}-${random_id.group_name.id} to manage volume-backups
    in compartment ${each.value}",
    "Allow group ${var.workload_storage_admins_group_name}-${each.value}-${random_id.group_name.id} to manage volume-groups
    in compartment ${each.value}",
    "Allow group ${var.workload_storage_admins_group_name}-${each.value}-${random_id.group_name.id} to manage volume-groups
    in compartment ${each.value}",
    "Allow group ${var.workload_storage_admins_group_name}-${each.value}-${random_id.group_name.id} to manage boot-volume-backups
    in compartment ${each.value}",
    "Allow group ${var.workload_storage_admins_group_name}-${each.value}-${random_id.group_name.id} to use volume-group-backups
    in compartment ${each.value}"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies Workload Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_admins_group" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload User Group" 
  name           = "${var.workload_admin_group_name}-${each.value}-${random_id.group_name.id}"
}

resource "oci_identity_policy" "workload_admins_policies" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.workload_compartment_ocids[each.value]
  description    = "OCI Landing Zone Workload User Policy"
  name           = "OCI-LZ-${each.value}-WorkloadAdminPolicy"
  statements = [
    "Allow group ${var.workload_admin_group_name}-${each.value}-${random_id.group_name.id} to manage instance-images in compartment ${each.value}",
    "Allow group ${var.workload_admin_group_name}-${each.value}-${random_id.group_name.id} to manage instance in compartment ${each.value}",
    "Allow group ${var.workload_admin_group_name}-${each.value}-${random_id.group_name.id} to manage instance-console-connection in compartment ${each.value}",
    "Allow group ${var.workload_admin_group_name}-${each.value}-${random_id.group_name.id} to manage app-catalog-listing in compartment ${each.value}",
    "Allow group ${var.workload_admin_group_name}-${each.value}-${random_id.group_name.id} to manage dedicated-vm-hosts in compartment ${each.value}",
    "Allow group ${var.workload_admin_group_name}-${each.value}-${random_id.group_name.id} to manage compute-management-family in compartment ${each.value}",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies Workload Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "workload_users_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Workload User"
  name           = "${var.workload_user_group_name}-${random_id.group_name.id}"
}

resource "oci_identity_policy" "workload_users_policies" {
  for_each       = toset(var.workload_compartment_name_list)
  compartment_id = var.workload_compartment_ocids[each.value]
  description    = "OCI Landing Zone Workload User Policy"
  name           = "OCI-LZ-${each.value}-WorkloadUserPolicy"
  freeform_tags = {
    "Description" = "Policy for access to all components in Load-balancing and use network family in Network compartment"
  }
  statements = [
    "Allow group ${oci_identity_group.lb_users_group.name} to use virtual-network-family in compartment ${each.value}",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Break Glass User Group Membership
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_user_group_membership" "administrator_group_membership" {
  for_each = data.oci_identity_users.break_glass_users
  group_id = oci_identity_group.administrator_group.id
  user_id  = each.value.users[0].id
}