# ---------------------------------------------------------------------------------------------------------------------
# Break Glass User Group Membership
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_user_group_membership" "administrator_group_membership" {
  for_each = data.oci_identity_users.break_glass_users
  group_id = var.administrator_group_id
  user_id  = each.value.users[0].id
}
