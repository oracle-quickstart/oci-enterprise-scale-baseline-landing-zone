# -----------------------------------------------------------------------------
# Create shared services private subnet
# -----------------------------------------------------------------------------
resource "oci_core_subnet" "fss_subnet" {
  cidr_block     = var.shared_service_subnet_cidr_block
  display_name   = "OCI-LZ-private-fss-subnet"
  dns_label      = var.shared_service_subnet_dns_label
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  freeform_tags = {
    "Description" = "Shared Service Subnet"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}