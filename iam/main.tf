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
# Create IAM groups
# ---------------------------------------------------------------------------------------------------------------------
module "groups" {
  source                         = "./groups"
  tenancy_ocid                   = var.tenancy_ocid
  workload_compartment_name_list = var.workload_compartment_name_list
  random_group_name_id           = random_id.group_name.id
  tag_cost_center                = var.tag_cost_center
  tag_geo_location               = var.tag_geo_location
}

# ---------------------------------------------------------------------------------------------------------------------
# Create IAM policies
# ---------------------------------------------------------------------------------------------------------------------
module "policies" {
  source                              = "./policies"
  tenancy_ocid                        = var.tenancy_ocid
  parent_compartment_id               = var.parent_compartment_id
  parent_compartment_name             = var.parent_compartment_name
  network_compartment_id              = var.network_compartment_id
  network_compartment_name            = var.network_compartment_name
  workload_compartment_name_list      = var.workload_compartment_name_list
  workload_compartment_ocids          = var.workload_compartment_ocids
  administrator_group_name            = module.groups.administrator_group_name
  network_admin_group_name            = module.groups.network_admin_group_name
  lb_users_group_name                 = module.groups.lb_users_group_name
  workload_storage_admins_group_names = module.groups.workload_storage_admins_group_names
  workload_storage_users_group_names  = module.groups.workload_storage_users_group_names
  workload_admins_group_names         = module.groups.workload_admins_group_names
  workload_users_group_names          = module.groups.workload_users_group_names
  security_admins_group_name          = module.groups.security_admins_group_name
  cloud_guard_operators_group_name    = module.groups.cloud_guard_operators_group_name
  cloud_guard_analysts_group_name     = module.groups.cloud_guard_analysts_group_name
  cloud_guard_architects_group_name   = module.groups.cloud_guard_architects_group_name
  region                              = var.region
  key_id                              = var.key_id
  vault_id                            = var.vault_id
  tag_cost_center                     = var.tag_cost_center
  tag_geo_location                    = var.tag_geo_location
  random_policy_name_id               = random_id.policy_name.id
  depends_on                          = [module.groups]
}

# ---------------------------------------------------------------------------------------------------------------------
# Break Glass Users
# ---------------------------------------------------------------------------------------------------------------------
module "users" {
  for_each                = {for index, email in var.break_glass_user_email_list: index => email}
  source                  = "./users"
  tenancy_ocid            = var.tenancy_ocid
  break_glass_user_index  = each.key
  break_glass_user_email  = each.value
  tag_cost_center         = var.tag_cost_center
  tag_geo_location        = var.tag_geo_location
  depends_on              = [module.groups]
}

# ---------------------------------------------------------------------------------------------------------------------
# Break Glass User Group Membership
# ---------------------------------------------------------------------------------------------------------------------
#module "membership" {
#  for_each               = module.users.break_glass_user_list
#  source                 = "./membership"
#  user_id                = each.value.id
#  administrator_group_id = module.groups.administrator_group_id
#  depends_on             = [module.groups]
#}

output "hihi" {
  value = module.users.*
}