# ---------------------------------------------------------------------------------------------------------------------
# Break Glass User Group Membership
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_user_group_membership" "administrator_group_membership" {
  for_each = var.break_glass_user_list
  group_id = var.administrator_group_id
  user_id  = each.value.id
}
