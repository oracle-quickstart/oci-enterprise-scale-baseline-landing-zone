data "oci_core_cpe_device_shapes" "cpe_device_shapes" {
}

data "oci_core_fast_connect_provider_services" "fast_connect_provider_services" {
    compartment_id = var.compartment_ocid
}
