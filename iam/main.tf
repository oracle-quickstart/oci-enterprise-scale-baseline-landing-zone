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
  source       = "./groups"
  tenancy_ocid = var.tenancy_ocid

  workload_compartment_name_list = var.workload_compartment_name_list
  random_group_name_id           = random_id.group_name.id
}

# ---------------------------------------------------------------------------------------------------------------------
# Create IAM policies
# ---------------------------------------------------------------------------------------------------------------------
module "policies" {
  source                              = "./policies"
  tenancy_ocid                        = var.tenancy_ocid
  parent_compartment_id               = var.parent_compartment_id
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
  random_policy_name_id               = random_id.policy_name.id
  depends_on                          = [module.groups]
}

# ---------------------------------------------------------------------------------------------------------------------
# Break Glass User Group Membership
# ---------------------------------------------------------------------------------------------------------------------
module "membership" {
  source                    = "./membership"
  tenancy_ocid              = var.tenancy_ocid
  break_glass_username_list = var.break_glass_username_list
  administrator_group_id    = module.groups.administrator_group_id
  depends_on                = [module.groups]
}
