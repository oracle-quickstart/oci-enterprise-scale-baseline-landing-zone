output "workload_compartment_ocids" {
  value = [ for workload in module.workload-compartment : workload.workload_compartment_id]
}