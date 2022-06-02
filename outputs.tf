# -----------------------------------------------------------------------------
# Output VCN and Subnets
# -----------------------------------------------------------------------------
output "vcn_ocid" {
  description = "VCN ocid"
  value       = module.vcn-core.vcn_id
}

output "compartments_map" {
  value       = local.compartments_map
  description = "Map of the compartments ocids"
}

output "subnet_map" {
  description = "Subnet list mapped to display name"
  value       = { for subnet in local.subnet_list : subnet.display_name => subnet.id }
}

output "more_info_url" {
  description = "For more information, please see the Cloud Adoption Framework - Technical Implementation"
  value       = "https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/technology-implementation.htm"
}
