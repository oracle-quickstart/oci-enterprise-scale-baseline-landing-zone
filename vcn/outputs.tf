# -----------------------------------------------------------------------------
# OCID Output
# -----------------------------------------------------------------------------
output "vcn_id" {
  value = oci_core_vcn.primary_vcn.id
}

output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = oci_core_subnet.private_subnet.*.id
}

output "database_subnet_id" {
  value = oci_core_subnet.database_subnet.*.id
}

output "fss_subnet_id" {
  value = oci_core_subnet.fss_subnet.id
}

output "workload_nat_route_table_id" {
  value = oci_core_route_table.workload_nat_route_table.*.id
}

output "database_nat_route_table_id" {
  value = oci_core_route_table.database_nat_route_table.*.id
}

output "service_gateway_route_table" {
  value = oci_core_route_table.service_gateway_route_table.id
}

output "provider_list" {
  value = data.oci_core_fast_connect_provider_services.test_fast_connect_provider_services.fast_connect_provider_services.*.provider_name
}
