# -----------------------------------------------------------------------------
# Create customer premises equipment object
# -----------------------------------------------------------------------------
resource "oci_core_cpe" "ipsec_vpn_cpe" {
  compartment_id = var.compartment_ocid
  ip_address     = var.cpe_ip_address

  cpe_device_shape_id = data.oci_core_cpe_device_shapes.cpe_device_shapes.cpe_device_shapes.0.cpe_device_shape_id
  display_name        = "OCI-LZ-CPE"
  freeform_tags = {
    "Description" = "Customer Premises Equipment"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# -----------------------------------------------------------------------------
# Create IPSec tunnel connection for site-to-site VPN
# -----------------------------------------------------------------------------
resource "oci_core_ipsec" "ipsec_connection" {
  compartment_id = var.compartment_ocid
  cpe_id         = oci_core_cpe.ipsec_vpn_cpe.id
  drg_id         = var.drg_id
  display_name   = "OCI-LZ-IPSEC-TUNNEL"
  static_routes  = var.ip_sec_connection_static_routes
  freeform_tags  = {
    "Description" = "IPSec tunnel connection"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}