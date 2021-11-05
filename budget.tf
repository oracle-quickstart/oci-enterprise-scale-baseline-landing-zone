# -----------------------------------------------------------------------------
# Create budgeting for parent compartment
# -----------------------------------------------------------------------------
module "budget" {
  source = "./budget"
  budget_target      = module.parent_compartment.parent_compartment_id
  budget_target_name = var.parent_compartment_name
}