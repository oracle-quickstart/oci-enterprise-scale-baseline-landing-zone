# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "vcn_id" {
  value = oci_core_vcn.primary_vcn.id
}

output "private_subnet" {
  value = oci_core_subnet.private_subnet
}

output "database_subnet" {
  value = oci_core_subnet.database_subnet
}

output "workload_nat_route_table_id" {
  value = oci_core_route_table.workload_nat_route_table.*.id
}

output "internet_gateway_id" {
  value = oci_core_internet_gateway.primary_internet_gateway.id
}

output "database_nat_route_table_id" {
  value = oci_core_route_table.database_nat_route_table.*.id
}

output "service_gateway_route_table" {
  value = oci_core_route_table.service_gateway_route_table.id
}

output "drg_id" {
  value = oci_core_drg.drg.id
}
