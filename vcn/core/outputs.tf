# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "vcn_id" {
  value = oci_core_vcn.primary_vcn.id
}

output "internet_gateway_id" {
  value = oci_core_internet_gateway.primary_internet_gateway.id
}

output "nat_gateway_id" {
  value = oci_core_nat_gateway.nat_gateway.id
}

output "drg_id" {
  value = oci_core_drg.drg.id
}
