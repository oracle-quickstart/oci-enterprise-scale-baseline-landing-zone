# -----------------------------------------------------------------------------
# Local Variables
# -----------------------------------------------------------------------------
locals {
  workload-list = flatten([
    for name in var.workload_compartment_names : {
      name = name
    }
  ])

  private-cidr-block-list = flatten([
    for cidr_block in var.private_subnet_cidr_blocks : {
      cidr_block = cidr_block
    }
  ])

  private-dns-label-list = flatten([
    for dns_label in var.private_subnet_dns_labels : {
      dns_label = dns_label
    }
  ])

  database-dns-label-list = flatten([
    for dns_label in var.database_subnet_dns_labels : {
      dns_label = dns_label
    }
  ])

  database-cidr-block-list = flatten([
    for cidr_block in var.database_subnet_cidr_blocks : {
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
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create Internet Gateway
# -----------------------------------------------------------------------------
resource "oci_core_internet_gateway" "primary_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "OCI-LZ-VCN-${var.region_key}-IGW"
  vcn_id         = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Primary VCN - Internet Gateway"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create private subnet for each workload
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "private_subnet" {
  count                      = length(local.workload-list)
  cidr_block                 = local.private-cidr-block-list[count.index].cidr_block
  display_name               = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-subnet"
  dns_label                  = local.private-dns-label-list[count.index].dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  route_table_id             = oci_core_route_table.workload_nat_route_table.*.id[count.index]
  prohibit_public_ip_on_vnic = true
  freeform_tags = {
    "Description" = "Private Subnet"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create NAT Gateway
# -----------------------------------------------------------------------------
resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "OCI-LZ-VCN-${var.region_key}-NGW"
  vcn_id         = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Primary VCN - NAT Gateway"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create route table for routing private workload subnets to NAT Gateway
# -----------------------------------------------------------------------------
resource "oci_core_route_table" "workload_nat_route_table" {
  count          = length(local.workload-list)
  compartment_id = var.compartment_ocid
  display_name   = "OCI-LZ-VCN-${local.workload-list[count.index].name}-${var.region_key}-RouteTable"
  vcn_id         = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Primary VCN - NAT route table for local.workload-list[count.index].name"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

# -----------------------------------------------------------------------------
# Create private database subnet for each workload
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "database_subnet" {
  count                      = length(local.workload-list)
  cidr_block                 = local.database-cidr-block-list[count.index].cidr_block
  display_name               = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-database-subnet"
  dns_label                  = local.database-dns-label-list[count.index].dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.primary_vcn.id
  route_table_id             = oci_core_route_table.database_nat_route_table.*.id[count.index]
  prohibit_public_ip_on_vnic = true
  freeform_tags = {
    "Description" = "Database Subnet"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create route table for routing private database subnets to NAT Gateway
# -----------------------------------------------------------------------------
resource "oci_core_route_table" "database_nat_route_table" {
  count          = length(local.workload-list)
  compartment_id = var.compartment_ocid
  display_name   = "OCI-LZ-VCN-${local.workload-list[count.index].name}-database-${var.region_key}-RouteTable"
  vcn_id         = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Primary VCN - Database NAT route table for ${local.workload-list[count.index].name}"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

# -----------------------------------------------------------------------------
# Create service gateway
# -----------------------------------------------------------------------------
resource "oci_core_service_gateway" "service_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "OCI-LZ-VCN-${var.region_key}-SGW"
  vcn_id         = oci_core_vcn.primary_vcn.id
  services {
    service_id = lookup(data.oci_core_services.service_gateway_all_oci_services.services[0], "id")
  }
  freeform_tags = {
    "Description" = "Primary VCN - Service gateway"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create service gateway route table
# -----------------------------------------------------------------------------
resource "oci_core_route_table" "service_gateway_route_table" {
  compartment_id = var.compartment_ocid
  display_name   = "ServiceGatewayRouteTable"
  vcn_id         = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Primary VCN - Service gateway route table"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  route_rules {
    destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = lookup(data.oci_core_services.service_gateway_all_oci_services.services[0], "cidr_block")
    network_entity_id = oci_core_service_gateway.service_gateway.id
  }
}

data "oci_core_services" "service_gateway_all_oci_services" {
  filter {
    name   = "name"
    values = ["All [A-Za-z0-9]+ Services In Oracle Services Network"]
    regex  = true
  }
}

# -----------------------------------------------------------------------------
# Create Dynamic Routing Gateway
# -----------------------------------------------------------------------------
resource "oci_core_drg" "drg" {
  compartment_id = var.compartment_ocid
  display_name   = "OCI-LZ-DRG"

  freeform_tags = {
    "Description" = "Dynamic Routing Gateways"
    "CostCenter"  = var.tag_cost_center
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create Dynamic Routing Gateway attachments
# -----------------------------------------------------------------------------
resource "oci_core_drg_attachment" "drg_vcn_attachment" {
  drg_id       = oci_core_drg.drg.id
  display_name = "OCI-LZ-DRG-VCN-ATTACHMENT"
  freeform_tags = {
    "Description" = "DRG VCN Attachment"
    "CostCenter"  = var.tag_cost_center
    "GeoLocation" = var.tag_geo_location
  }
  network_details {
    id   = oci_core_vcn.primary_vcn.id
    type = "VCN"
  }
}

# -----------------------------------------------------------------------------
# Lock Down Default Security List
# -----------------------------------------------------------------------------
resource "oci_core_default_security_list" "default_security_list_locked_down" {
  manage_default_resource_id = oci_core_vcn.primary_vcn.default_security_list_id
}
