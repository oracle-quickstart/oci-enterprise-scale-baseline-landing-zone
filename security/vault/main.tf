resource "oci_kms_vault" "vault" {
  compartment_id = var.security_compartment_ocid
  display_name   = var.vault_display_name
  vault_type     = "DEFAULT"

  freeform_tags = {
    "Description" = "KMS Vault"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}