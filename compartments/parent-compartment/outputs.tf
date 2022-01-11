# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "parent_compartment_id" {
  value = oci_identity_compartment.parent_compartment.id
}

output "parent_compartment_name" {
  value = oci_identity_compartment.parent_compartment.name
}