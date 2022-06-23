output "key_management_endpoint" {
  value = oci_kms_vault.vault.management_endpoint
}

output "vault_id" {
  value = oci_kms_vault.vault.id
}