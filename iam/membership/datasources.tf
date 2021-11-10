data "oci_identity_users" "break_glass_users" {
  for_each       = toset(var.break_glass_username_list)
  compartment_id = var.tenancy_ocid
  name           = each.value
}
