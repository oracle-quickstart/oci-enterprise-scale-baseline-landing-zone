locals {
  workload-list = flatten([
    for name in var.workload_compartment_names: {
      name = name
    }
  ])
}

resource "oci_core_vcn" "primary_vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_ocid
  display_name   = "Primary VCN"
  dns_label      = var.vcn_dns_label
  freeform_tags = {
    "Description" = "Primary VCN"
  }
}

resource "oci_core_subnet" "public_subnet" {
  cidr_block                 = var.public_subnet_cidr_block
  display_name               = "OCI-LZ-Public-${var.region_key}-subnet"
  dns_label                  = var.public_subnet_dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Public Subnet"
  }
}

resource "oci_core_subnet" "private_subnet" {
  count                      = length(local.workload-list)
  cidr_block                 = var.private_subnet_cidr_block
  display_name               = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-subnet"
  dns_label                  = var.private_subnet_dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Private Subnet"
  }
}

resource "oci_core_subnet" "database_subnet" {
  count                      = length(local.workload-list)
  cidr_block                 = var.database_subnet_cidr_block
  display_name               = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-database-subnet"
  dns_label                  = var.database_subnet_dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Database Subnet"
  }
}

resource "oci_core_subnet" "fss_subnet" {
  cidr_block                 = var.shared_service_subnet_cidr_block
  display_name               = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-subnet"
  dns_label                  = var.shared_service_subnet_dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Shared Service Subnet"
  }
}

