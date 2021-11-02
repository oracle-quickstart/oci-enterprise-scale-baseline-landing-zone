# ---------------------------------------------------------------------------------------------------------------------
# Create benchmarking parent compartment under root compartment
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_compartment" "benchmarking_compartment" {
  compartment_id  = var.tenancy_ocid
  description     = "Benchmarking Compartment"
  name            = "${var.unique_prefix}_benchmarking"
  freeform_tags   = {
    "Description" = "Benchmarking Compartment"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create dynamic group and IAM policy for access to RSA resources
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_dynamic_group" "benchmarking_dynamic_group" {
  compartment_id  = var.tenancy_ocid
  description     = "OCI RSA Benchmarking Instances"
  matching_rule   = "tag.${oci_identity_tag_namespace.benchmarking_tag_namespace.name}.${oci_identity_tag.benchmarking_tag.name}.value"
  name            = "${var.unique_prefix}_benchmarking_instances"
  freeform_tags   = {
    "Description" = "Dynamic group for access to RSA benchmarking bucket"
    "Function"    = "Provides access to the RSA benchmarking bucket"
  }
}

resource "oci_identity_policy" "rsa_access_policy" {
  compartment_id  = oci_identity_compartment.benchmarking_compartment.id
  description     = "OCI RSA Benchmarking Object Store Access"
  name            = "${var.unique_prefix}_benchmarking_resource_access"
  freeform_tags   = {
    "Description" = "Policy for access to RSA benchmarking resources"
    "Function"    = "Provides access to the RSA benchmarking resources"
  }
  statements = [
    "Allow dynamic-group ${oci_identity_dynamic_group.benchmarking_dynamic_group.name} to use all-resources in compartment id ${oci_identity_compartment.benchmarking_compartment.id}",
    "Allow dynamic-group ${oci_identity_dynamic_group.benchmarking_dynamic_group.name} to read buckets in compartment id ${oci_identity_compartment.benchmarking_compartment.id}",
    "Allow dynamic-group ${oci_identity_dynamic_group.benchmarking_dynamic_group.name} to read objects in compartment id ${oci_identity_compartment.benchmarking_compartment.id} where target.bucket.name='${var.bootstrap_bucket}'",
    "Allow dynamic-group ${oci_identity_dynamic_group.benchmarking_dynamic_group.name} to read objects in compartment id ${oci_identity_compartment.benchmarking_compartment.id} where target.bucket.name='${var.reporting_bucket}'",
    "Allow dynamic-group ${oci_identity_dynamic_group.benchmarking_dynamic_group.name} to manage objects in compartment id ${oci_identity_compartment.benchmarking_compartment.id} where all { target.bucket.name='${var.reporting_bucket}', any {request.permission='OBJECT_CREATE', request.permission='OBJECT_INSPECT'}}"
  ]
}
