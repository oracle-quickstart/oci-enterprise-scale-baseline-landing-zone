# -----------------------------------------------------------------------------
# Output workload compartment OCIDs
# -----------------------------------------------------------------------------
output "workload_compartment_ocids" {
  description = "Workload compartments to deploy applications to"
  value       = module.workload-compartment
}

# -----------------------------------------------------------------------------
# Output VCN and Subnets
# -----------------------------------------------------------------------------
output "vcn_ocid" {
  description = "VCN ocid"
  value       = module.vcn.vcn_id
}

output "public_subnet_id" {
  description = "Public subnet ocid"
  value       = module.vcn.public_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ocid"
  value       = module.vcn.private_subnet_id
}

output "database_subnet_id" {
  description = "Database subnet ocid"
  value       = module.vcn.database_subnet_id
}

output "fss_subnet_id" {
  description = "Shared service subnet ocid"
  value       = module.vcn.fss_subnet_id
}

output "provider_list" {
  value = module.vcn.provider_list
}
