data "oci_identity_users" "break_glass_users" {
  count          = length(var.break_glass_username_list)
  compartment_id = var.tenancy_ocid
  name           = var.break_glass_username_list[count.index]
}
