# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "network_compartment_id" {
  value = oci_identity_compartment.network_compartment.id
}

output "network_compartment_name" {
  value = oci_identity_compartment.network_compartment.name
}

