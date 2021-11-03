variable "unique_prefix" {

}

variable "tenancy_ocid" {

}

variable "root_compartment_name" {
    type = string
    default = "LZ v.1.0"
}

variable "commoninfra_compartment_name" {
    type = string
    default = "Common Infra"
}

variable "application_compartment_name" {
    type = string
    default = "Applications"
}

resource "oci_identity_compartment" "root_compartment" {
  compartment_id  = var.tenancy_ocid
  description     = var.root_compartment_name
  name            = "${var.unique_prefix}_${var.root_compartment_name}"
}

output "root_compartment_id" {
  value = oci_identity_compartment.root_compartment.id
}

output "root_compartment_name" {
  value = oci_identity_compartment.root_compartment.name
}

resource "oci_identity_compartment" "commoninfra_compartment" {
  compartment_id  = oci_identity_compartment.root_compartment.id
  description     = var.commoninfra_compartment_name
  name            = "${var.unique_prefix}_${var.common_infra_compartment_name}"
}

output "commoninfra_compartment_name" {
  value = oci_identity_compartment.commoninfra_compartment.name
}

resource "oci_identity_compartment" "applications_compartment" {
  compartment_id  = oci_identity_compartment.root_compartment.id
  description     = var.application_compartment_name
  name            = "${var.unique_prefix}_${var.applications_compartment_name}"
}

output "applications_compartment_name" {
  value = oci_identity_compartment.test_compartment.name
}
