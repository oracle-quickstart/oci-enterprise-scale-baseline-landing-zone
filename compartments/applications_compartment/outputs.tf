# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "applications_compartment_id" {
  value = oci_identity_compartment.applications_compartment.id
}

output "applications_compartment_name" {
  value = oci_identity_compartment.applications_compartment.name
}