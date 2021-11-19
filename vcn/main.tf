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
# Create default route table for public subnet
# -----------------------------------------------------------------------------
resource "oci_core_route_table" "public_subnet_route_table" {
  compartment_id = var.compartment_ocid
  display_name   = "OCI-LZ-VCN-${var.region_key}-PublicSubnet-RouteTable"
  vcn_id         = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Primary VCN - Public Subnet route table"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.primary_internet_gateway.id
  }
}

# -----------------------------------------------------------------------------
# Create security list for each workloads
# -----------------------------------------------------------------------------
resource "oci_core_security_list" "workload_security_list" {
  count          = length(local.workload-list)
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.primary_vcn.id
  display_name   = "OCI-LZ-VCN-${var.region_key}-${local.workload-list[count.index].name}-SecurityList"
  freeform_tags = {
    "Description" = "Security list for ${local.workload-list[count.index].name}"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  dynamic "egress_security_rules" {
    for_each = var.egress_rules_map
    content {
      description = var.egress_security_rules_description
      destination = var.vcn_cidr_block
      protocol    = var.egress_security_rules_protocol
      stateless   = var.egress_security_rules_stateless
      tcp_options {
        max = egress_security_rules.value.egress_security_rules_tcp_options_destination_port_range_max
        min = egress_security_rules.value.egress_security_rules_tcp_options_destination_port_range_min
        source_port_range {
          max = egress_security_rules.value.egress_security_rules_tcp_options_source_port_range_max
          min = egress_security_rules.value.egress_security_rules_tcp_options_source_port_range_min
        }
      }
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.ingress_rules_map
    content {
      description = var.ingress_security_rules_description
      protocol    = var.ingress_security_rules_protocol
      source      = var.vcn_cidr_block
      stateless   = var.ingress_security_rules_stateless
      tcp_options {
        max = ingress_security_rules.value.ingress_security_rules_tcp_options_destination_port_range_max
        min = ingress_security_rules.value.ingress_security_rules_tcp_options_destination_port_range_min
        source_port_range {
          max = ingress_security_rules.value.ingress_security_rules_tcp_options_source_port_range_max
          min = ingress_security_rules.value.ingress_security_rules_tcp_options_source_port_range_min
        }
      }
    }
  }
}

# -----------------------------------------------------------------------------
# Create public subnet
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "public_subnet" {
  cidr_block        = var.public_subnet_cidr_block
  display_name      = "OCI-LZ-Public-${var.region_key}-subnet"
  dns_label         = var.public_subnet_dns_label
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.primary_vcn.id
  route_table_id    = oci_core_route_table.public_subnet_route_table.id
  security_list_ids = oci_core_security_list.workload_security_list.*.id
  freeform_tags = {
    "Description" = "Public Subnet"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create private subnet for each workload
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "private_subnet" {
  count          = length(local.workload-list)
  cidr_block     = local.private-cidr-block-list[count.index].cidr_block
  display_name   = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-subnet"
  dns_label      = local.private-dns-label-list[count.index].dns_label
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.primary_vcn.id
  route_table_id = oci_core_route_table.workload_nat_route_table.*.id[count.index]
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
    "Description" = "Primary VCN - NAT route table for ${local.workload-list[count.index].name}"
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
  count          = length(local.workload-list)
  cidr_block     = local.database-cidr-block-list[count.index].cidr_block
  display_name   = "OCI-LZ-private-${local.workload-list[count.index].name}-${var.region_key}-database-subnet"
  dns_label      = local.database-dns-label-list[count.index].dns_label
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.primary_vcn.id
  route_table_id = oci_core_route_table.database_nat_route_table.*.id[count.index]
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
# Create shared services private subnet
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "fss_subnet" {
  cidr_block     = var.shared_service_subnet_cidr_block
  display_name   = "OCI-LZ-private-fss-subnet"
  dns_label      = var.shared_service_subnet_dns_label
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.primary_vcn.id
  freeform_tags = {
    "Description" = "Shared Service Subnet"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
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
