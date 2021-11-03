# -----------------------------------------------------------------------------
# Output workload compartment OCIDs
# -----------------------------------------------------------------------------
output "workload_compartment_ocids" {
  description = "Workload compartments to deploy applications to"
  value       = module.workload-compartment[*]
}