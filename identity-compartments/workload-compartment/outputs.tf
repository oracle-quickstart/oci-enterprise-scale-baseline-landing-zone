# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "workload_compartment_id" {
  value = oci_identity_compartment.workload_compartment.id
}