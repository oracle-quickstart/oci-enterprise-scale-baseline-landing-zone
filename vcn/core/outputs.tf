# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "vcn_id" {
  value = oci_core_vcn.primary_vcn.id
}

output "internet_gateway_id" {
  value = oci_core_internet_gateway.primary_internet_gateway.id
}

output "service_gateway_route_table" {
  value = oci_core_route_table.service_gateway_route_table.id
}

output "drg_id" {
  value = oci_core_drg.drg.id
}
