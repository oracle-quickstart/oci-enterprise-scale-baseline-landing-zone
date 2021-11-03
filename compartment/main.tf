variable "unique_prefix" {
}

variable "tenancy_ocid" {

}

variable "root_compartment_name" {
  type    = string
  default = "LZ-v.1.0"
}

variable "commoninfra_compartment_name" {
  type    = string
  default = "Common-Infra"
}

variable "network_compartment_name" {
  type    = string
  default = "Network"
}

variable "security_compartment_name" {
  type    = string
  default = "Security"
}

variable "application_compartment_name" {
  type    = string
  default = "Applications"
}

variable "workload_compartment_name_list" {
  type    = string
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies for Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_compartment" "root_compartment" {
  compartment_id = var.tenancy_ocid
  description    = var.root_compartment_name
  name           = "${var.unique_prefix}_${var.root_compartment_name}"
}

output "root_compartment_id" {
  value = oci_identity_compartment.root_compartment.id
}

output "root_compartment_name" {
  value = oci_identity_compartment.root_compartment.name
}

# ---------------------------------------------------------------------------------------------------------------------
# common infra
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_compartment" "commoninfra_compartment" {
  compartment_id = oci_identity_compartment.root_compartment.id
  description    = var.commoninfra_compartment_name
  name           = "${var.commoninfra_compartment_name}"
}

output "commoninfra_compartment_name" {
  value = oci_identity_compartment.commoninfra_compartment.name
}

output "commoninfra_compartment_id" {
  value = oci_identity_compartment.commoninfra_compartment.id
}

resource "oci_identity_compartment" "network_compartment" {
  compartment_id = oci_identity_compartment.commoninfra_compartment.id
  description    = var.network_compartment_name
  name           = "${var.network_compartment_name}"
}

output "network_compartment_name" {
  value = oci_identity_compartment.network_compartment.name
}

output "network_compartment_id" {
  value = oci_identity_compartment.network_compartment.name
}

# resource "oci_identity_compartment" "commoninfra_compartment" {
#   compartment_id  = oci_identity_compartment.root_compartment.id
#   description     = var.commoninfra_compartment_name
#   name            = "${var.common_infra_compartment_name}"
# }

# output "commoninfra_compartment_name" {
#   value = oci_identity_compartment.commoninfra_compartment.name
# }

# output "commoninfra_compartment_id" {
#   value = oci_identity_compartment.commoninfra_compartment.id
# }

# ---------------------------------------------------------------------------------------------------------------------
# application
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_compartment" "application_compartment" {
  compartment_id = oci_identity_compartment.root_compartment.id
  description    = var.application_compartment_name
  name           = "${var.application_compartment_name}"
}

output "application_compartment_name" {
  value = oci_identity_compartment.application_compartment.name
}

output "application_compartment_id" {
  value = oci_identity_compartment.application_compartment.id
}

resource "oci_identity_compartment" "workload_compartment" {
  count = length(var.workload_compartment_name_list)
  compartment_id = oci_identity_compartment.application_compartment.id
  description    = var.workload_compartment_name_list[count.index]
  name           = "${var.workload_compartment_name[count.index]}"
}

output "workload_compartment_name" {
  value = oci_identity_compartment.workload_compartment.*.name
}

output "workload_compartment_id" {
  value = oci_identity_compartment.workload_compartment.*.id
}
