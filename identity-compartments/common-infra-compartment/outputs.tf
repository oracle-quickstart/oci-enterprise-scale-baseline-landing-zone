# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "common_infra_compartment_id" {
  value = oci_identity_compartment.common_infra_compartment.id
}