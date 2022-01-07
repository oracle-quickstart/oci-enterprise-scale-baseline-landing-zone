locals {
  workload-list = flatten([
    for name in var.workload_compartment_names : {
      name = name
    }
  ])

  customized-egress-rule-list = flatten([
    for workload-name in var.workload_compartment_names : {
      rule_name = can(var.egress_rules_map[workload-name]) ? workload-name : "default"
    }
  ])

  customized-ingress-rule-list = flatten([
    for workload-name in var.workload_compartment_names : {
      rule_name = can(var.ingress_rules_map[workload-name]) ? workload-name : "default"
    }
  ])
}

# -----------------------------------------------------------------------------
# Create default route table for public subnet
# -----------------------------------------------------------------------------
resource "oci_core_route_table" "public_subnet_route_table" {
  compartment_id = var.compartment_ocid
  display_name   = "OCI-LZ-VCN-${var.region_key}-PublicSubnet-RouteTable"
  vcn_id         = var.vcn_id
  freeform_tags = {
    "Description" = "Primary VCN - Public Subnet route table"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = var.internet_gateway_id
  }
}

# -----------------------------------------------------------------------------
# Create security list for each workloads
# -----------------------------------------------------------------------------
resource "oci_core_security_list" "workload_security_list" {
  for_each       = setunion(toset(keys(var.egress_rules_map)), toset(keys(var.ingress_rules_map)))
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = "OCI-LZ-VCN-${var.region_key}-${each.key}-SecurityList"
  freeform_tags = {
    "Description" = "Security list for ${each.key}"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  dynamic "egress_security_rules" {
    for_each = can(var.egress_rules_map[each.key]) ? toset(var.egress_rules_map[each.key]) : []
    content {
      description = var.egress_security_rules_description
      destination = var.vcn_cidr_block
      protocol    = var.egress_security_rules_protocol
      stateless   = var.egress_security_rules_stateless
      tcp_options {
        max = egress_security_rules.key["egress_security_rules_tcp_options_destination_port_range_max"]
        min = egress_security_rules.key["egress_security_rules_tcp_options_destination_port_range_min"]
        source_port_range {
          max = egress_security_rules.key["egress_security_rules_tcp_options_source_port_range_max"]
          min = egress_security_rules.key["egress_security_rules_tcp_options_source_port_range_min"]
        }
      }
    }
  }

  dynamic "ingress_security_rules" {
    for_each = can(var.ingress_rules_map[each.key]) ? toset(var.ingress_rules_map[each.key]) : []
    content {
      description = var.ingress_security_rules_description
      source      = var.vcn_cidr_block
      protocol    = var.ingress_security_rules_protocol
      stateless   = var.ingress_security_rules_stateless
      tcp_options {
        max = ingress_security_rules.key["ingress_security_rules_tcp_options_destination_port_range_max"]
        min = ingress_security_rules.key["ingress_security_rules_tcp_options_destination_port_range_min"]
        source_port_range {
          max = ingress_security_rules.key["ingress_security_rules_tcp_options_source_port_range_max"]
          min = ingress_security_rules.key["ingress_security_rules_tcp_options_source_port_range_min"]
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
  vcn_id            = var.vcn_id
  route_table_id    = oci_core_route_table.public_subnet_route_table.id
  security_list_ids = values(oci_core_security_list.workload_security_list)[*].id
  freeform_tags = {
    "Description" = "Public Subnet"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

