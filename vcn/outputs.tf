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
