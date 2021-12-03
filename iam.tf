# -----------------------------------------------------------------------------
# Create IAM resources (policies, groups)
# -----------------------------------------------------------------------------
module "iam" {
  source                         = "./iam"
  tenancy_ocid                   = var.tenancy_ocid
  parent_compartment_id          = module.parent-compartment.parent_compartment_id
  parent_compartment_name        = var.parent_compartment_name
  network_compartment_id         = module.network-compartment.network_compartment_id
  network_compartment_name       = var.network_compartment_name
  workload_compartment_name_list = var.workload_compartment_names
  workload_compartment_ocids     = module.workload-compartment
  break_glass_user_email_list    = var.break_glass_user_email_list
  region                         = var.region
  key_id                         = var.key_id
  vault_id                       = var.vault_id
  tag_cost_center                = var.tag_cost_center
  tag_geo_location               = var.tag_geo_location
  depends_on = [
    module.parent-compartment, module.network-compartment, module.workload-compartment
  ]
}