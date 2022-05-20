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
