resource "random_id" "user_name" {
  byte_length = 8
}

resource "oci_identity_user" "break_glass_user" {
    for_each = {for index, email in var.break_glass_user_email_list: index => email}
    compartment_id = var.tenancy_ocid
    description    = "Break glass user ${each.key}"
    name           = "break_glass_user_${each.key}_${random_id.user_name.hex}"
    email          = each.value
    freeform_tags  = {
    "Description"  = "Break glass users",
    "CostCenter"   = var.tag_cost_center,
    "GeoLocation"  = var.tag_geo_location
  }
}