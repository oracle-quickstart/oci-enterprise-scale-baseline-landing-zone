# -----------------------------------------------------------------------------
# Local Variables
# -----------------------------------------------------------------------------
locals {
  workload-list = flatten([
    for name in var.workload_compartment_names: {
      name = name
    }
  ])
}

locals {
  private-cidr-block-list = flatten([
    for cidr_block in var.private_subnet_cidr_blocks: {
      cidr_block = cidr_block
    }
  ])
}

locals {
  private-dns-label-list = flatten([
    for dns_label in var.private_subnet_dns_labels: {
      dns_label = dns_label
    }
  ])
}

locals {
  database-dns-label-list = flatten([
    for dns_label in var.database_subnet_dns_labels: {
      dns_label = dns_label
    }
  ])
}

locals {
  database-cidr-block-list = flatten([
    for cidr_block in var.database_subnet_cidr_blocks: {
      cidr_block = cidr_block
    }
  ])
}

# -----------------------------------------------------------------------------
# Create VCN
# -----------------------------------------------------------------------------
resource "oci_core_vcn" "primary_vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_ocid
  display_name   = "Primary VCN"
  dns_label      = var.vcn_dns_label
  freeform_tags = {
    "Description" = "Primary VCN"
  }
}

# -----------------------------------------------------------------------------
# Create public subnet
# -----------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------
# Create private subnet for each workloads
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "private_subnet" {
  count                      = length(local.workload-list)
  cidr_block                 = local.private-cidr-block-list[count.index].cidr_block
  display_name               = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-subnet"
  dns_label                  = local.private-dns-label-list[count.index].dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Private Subnet"
  }
}

# -----------------------------------------------------------------------------
# Create database subnet for each workloads
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "database_subnet" {
  count                      = length(local.workload-list)
  cidr_block                 = local.database-cidr-block-list[count.index].cidr_block
  display_name               = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-database-subnet"
  dns_label                  = local.database-dns-label-list[count.index].dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Database Subnet"
  }
}

# -----------------------------------------------------------------------------
# Create shared service subnet
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "fss_subnet" {
  cidr_block                 = var.shared_service_subnet_cidr_block
  display_name               = "OCI-LZ-private-fss-subnet"
  dns_label                  = var.shared_service_subnet_dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Shared Service Subnet"
  }
}

