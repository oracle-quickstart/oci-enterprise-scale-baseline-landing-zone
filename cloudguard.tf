# variable "tenancy_ocid" {
#   type        = string
#   description = "The OCID of tenancy"
# }

# variable "workload_compartment_ocids" {
#   description = "The list of workload compartments"
# }

# # -----------------------------------------------------------------------------
# # Identity Compartment Variables
# # -----------------------------------------------------------------------------
# variable "parent_compartment_name" {
#   type        = string
#   description = "The name of the top level / parent compartment"
# }

# variable "parent_compartment_id" {
#   type        = string
#   description = "The OCID of the top level / parent compartment"
# }

# variable "network_compartment_id" {
#   type        = string
#   description = "The OCID of the network compartment"
# }

# variable "network_compartment_name" {
#   type        = string
#   description = "The name for the network compartment"
# }

# variable "workload_compartment_name_list" {
#   type        = list(string)
#   description = "List of application workload compartment names"
# }

# # -----------------------------------------------------------------------------
# # IAM Group Variables
# # -----------------------------------------------------------------------------
# variable "administrator_group_name" {
#   type        = string
#   description = "The name for the administrator group"
#   default     = "Administrators"
# }

# variable "network_admin_group_name" {
#   type        = string
#   description = "The name for the network administrator group name"
#   default     = "Virtual-Network-Admins"
# }

# variable "lb_users_group_name" {
#   type        = string
#   description = "The name for the load balancer users group name"
#   default     = "LBUsers"
# }

# variable "workload_storage_admins_group_name" {
#   type        = string
#   description = "The name for the workload storage administrators group"
#   default     = "Workload-Storage-Admins"
# }

# variable "workload_storage_users_group_name" {
#   type        = string
#   description = "The name for the workload storage users group"
#   default     = "Workload-Storage-Users"
# }

# variable "workload_admin_group_name" {
#   type        = string
#   description = "The name for the workload administrators group"
#   default     = "Workload-Admins"
# }

# variable "workload_user_group_name" {
#   type        = string
#   description = "The name for the workload users group"
#   default     = "Workload-Users"
# }

# variable "security_admin_group_name" {
#   type        = string
#   description = "The name of the security admin group"
#   default     = "SecurityAdmins"
# }

# variable "cloudguard_analyst_group_name" {
#   type        = string
#   description = "The name of the cloudguard analyst group"
#   default     = "CloudGuard-Analyst"
# }

# # -----------------------------------------------------------------------------
# # IAM Policy Variables
# # -----------------------------------------------------------------------------
# variable "administrator_policy_name" {
#   type    = string
#   default = "OCI-LZ-Admin-TenantAdminPolicy"
# }

# variable "network_admin_policy_name" {
#   type    = string
#   default = "OCI-LZ-VCNAdminPolicy"
# }

# variable "security_admin_policy_name" {
#   type        = string
#   description = "The name of the security admin group"
#   default     = "OCI-LZ-SecurityAdmins"
# }

# variable "cloudguard_analyst_policy_name" {
#   type        = string
#   description = "The name of the cloudguard analyst group"
#   default     = "OCI-LZ-CGOps"
# }

# # -----------------------------------------------------------------------------
# # Break Glass User Variable
# # -----------------------------------------------------------------------------
# variable "break_glass_username_list" {
#   type        = list(string)
#   description = "The list break glass admin users"
# }

# # ---------------------------------------------------------------------------------------------------------------------
# # IAM Group and Policies Workload Users
# # ---------------------------------------------------------------------------------------------------------------------
# resource "oci_identity_group" "workload_users_group" {
#   for_each       = toset(var.workload_compartment_name_list)
#   compartment_id = var.tenancy_ocid
#   description    = "OCI Landing Zone Workload User"
#   name           = "${var.workload_user_group_name}-${each.value}-${random_id.group_name.id}"
# }

# resource "oci_identity_policy" "workload_users_policies" {
#   for_each       = toset(var.workload_compartment_name_list)
#   compartment_id = var.workload_compartment_ocids[0][each.value].workload_compartment_id
#   description    = "OCI Landing Zone Workload User Policy"
#   name           = "OCI-LZ-${each.value}-WorkloadUserPolicy"
#   freeform_tags = {
#     "Description" = "Policy for Workload Specific Users"
#   }
#   statements = [
#     # Ability to do everything with instances launched into the cloud network and subnets 
#     "Allow group ${var.workload_user_group_name}-${each.value}-${random_id.group_name.id} to manage instance in compartment ${each.value}",
#     "Allow group ${var.workload_admin_group_name}-${each.value}-${random_id.group_name.id} to use virtual-network-family in compartment ${each.value}",
#     # Ability to create instance console creation
#     "Allow group ${var.workload_user_group_name}-${each.value}-${random_id.group_name.id} to manage instance-console-connection in compartment ${each.value}",
#     # Ability to list and create subscriptions to images in partner image catalog.
#     "Allow group ${var.workload_user_group_name}-${each.value}-${random_id.group_name.id} to manage app-catalog-listing in compartment ${each.value}",
#     # Ability to launch instances on dedicated virtual machine hosts
#     "Allow group ${var.workload_user_group_name}-${each.value}-${random_id.group_name.id} to use dedicated-vm-hosts in compartment ${each.value}",
#   ]

#   depends_on = [
#     oci_identity_group.workload_users_group
#   ]
# }

# # ---------------------------------------------------------------------------------------------------------------------
# # IAM Group and Policies Security Admins
# # ---------------------------------------------------------------------------------------------------------------------
# resource "oci_identity_group" "security_admins_group" {
#   compartment_id = var.tenancy_ocid
#   description    = "OCI Landing Zone Security Admin"
#   name           = "${var.security_admin_group_name}-${random_id.group_name.id}"
# }

# resource "oci_identity_policy" "security_admins_policy" {
#   compartment_id = var.parent_compartment_id
#   description    = "OCI Landing Zone Security Admin Policy"
#   name           = var.security_admin_policy_name
#   freeform_tags = {
#     "Description" = "Policy for Security Admin Users"
#   }

#   statements = [
#     # Ability to associate an Object Storage bucket, Block Volume volume, File Storage file system, Kubernetes cluster, or Streaming stream pool with a specific key
#     "Allow group ObjectWriters, VolumeWriters, FileWriters, ClusterWriters, StreamWriters to use key-delegate in compartment ABC where target.key.id = '<key_OCID>'",
#     # Ability to list, view, and perform cryptographic operations with all keys in compartment 
#     "Allow group SecurityAdmins to use keys in compartment ABC",
#     "Allow service blockstorage, objectstorage-<region_name>, FssOc1Prod, oke, streaming to use keys in compartment ABC where target.key.id = '<key_OCID>'",
#     # Ability to do all things with secrets in a specific vault in compartment ABC.
#     "Allow group SecurityAdmins to manage secret-family in compartment ABC where target.vault.id='<vault_OCID>'",
#     # Ability to manage all resources in the Bastion service in all compartments
#     "Allow group SecurityAdmins to manage bastion in tenancy",
#     "Allow group SecurityAdmins to manage bastion-session in tenancy",
#     "Allow group SecurityAdmins to manage virtual-network-family in tenancy",
#     "Allow group SecurityAdmins to read instance-family in tenancy",
#     "Allow group SecurityAdmins to read instance-agent-plugins in tenancy",
#     "Allow group SecurityAdmins to inspect work-requests in tenancy",
#   ]

#   depends_on = [
#     oci_identity_group.security_admin_group
#   ]
# }

# # ---------------------------------------------------------------------------------------------------------------------
# # IAM Group and Policies Security Admins
# # ---------------------------------------------------------------------------------------------------------------------
# resource "oci_identity_group" "cloudguard_analyst_group" {
#   compartment_id = var.tenancy_ocid
#   description    = "OCI Landing Zone Cloudguard Analyst"
#   name           = "${var.cloudguard_analyst_group_name}-${random_id.group_name.id}"
# }

# resource "oci_identity_policy" "security_admins_policy" {
#   compartment_id = var.parent_compartment_id
#   description    = "OCI Landing Zone Cloud Guard Analyst Policy"
#   name           = var.cloudguard_analyst_policy_name
#   freeform_tags = {
#     "Description" = "Policy for Cloud Guard Analyst Users"
#   }

#   statements = [
#     # Read-only access to Cloud Guard problems
#     "Allow group CloudGuard_ReadOnlyProblems to read cloud-guard-family in tenancy",
#     "Allow group CloudGuard_ReadOnlyProblems to inspect cloud-guard-detectors in tenancy",
#     "Allow group CloudGuard_ReadOnlyProblems to inspect cloud-guard-targets in tenancy",
#     "Allow group CloudGuard_ReadOnlyProblems to inspect cloud-guard-resource-types in tenancy",
#     "allow group CloudGuard_ReadOnlyProblems to read announcements in tenancy",
#     "allow group CloudGuard_ReadOnlyProblems to read compartments in tenancy",
#     "allow group CloudGuard_ReadOnlyProblems to read cloud-guard-config in tenancy",
#     # Read-only access to Cloud Guard detector recipes
#     "allow group CloudGuard_ReadOnlyDetectors to read cloud-guard-detector-recipes in tenancy",
#     "allow group CloudGuard_ReadOnlyDetectors to read announcements in tenancy",
#     "allow group CloudGuard_ReadOnlyDetectors to read compartments in tenancy",
#     "allow group CloudGuard_ReadOnlyDetectors to read cloud-guard-config in tenancy"
#   ]

#   depends_on = [
#     oci_identity_group.security_admin_group
#   ]
# }

