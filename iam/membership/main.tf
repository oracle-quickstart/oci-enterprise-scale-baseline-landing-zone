# ---------------------------------------------------------------------------------------------------------------------
# Break Glass User Group Membership
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_user_group_membership" "administrator_group_membership" {
  group_id = var.administrator_group_id
  user_id  = var.user_id
}
