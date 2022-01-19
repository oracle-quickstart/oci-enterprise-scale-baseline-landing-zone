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
  value       = module.vcn-core.vcn_id
}

output "public_subnet_id" {
  description = "Public subnet ocid"
  value       = var.is_public_subnet_enabled == true ? module.public_subnet[0].public_subnet.id : null
}

output "private_subnet_id" {
  description = "Private subnet ocid"
  value       = module.vcn-core.private_subnet.*.id
}

output "database_subnet_id" {
  description = "Database subnet ocid"
  value       = module.vcn-core.database_subnet.*.id
}

output "fss_subnet_id" {
  description = "Shared service subnet ocid"
  value       = var.is_shared_services_subnet_enabled == true ? module.fss_subnet[0].fss_subnet.id : null
}

output "subnet_map" {
  description = "Subnet list mapped to display name"
  value       = { for subnet in local.subnet_list : subnet.display_name => subnet.id }
}

output "more_info_url" {
  description = "For more information, please see the Cloud Adoption Framework - Technical Implementation"
  value       = "https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/technology-implementation.htm"
}
