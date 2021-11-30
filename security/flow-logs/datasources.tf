data "oci_core_subnets" "vcn_subnets" {
  compartment_id = var.network_compartment_ocid
  vcn_id         = var.vcn_id
}
