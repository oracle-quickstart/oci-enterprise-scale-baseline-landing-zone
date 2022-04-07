resource "random_id" "tag" {
  byte_length = 2
}

resource "oci_identity_tag_namespace" "ArchitectureCenterTagNamespace" {
  compartment_id = var.tenancy_ocid
  description    = "ArchitectureCenterTagNamespace"
  name           = "ArchitectureCenter\\oci-enterprise-scale-baseline-landing-zone-${random_id.tag.hex}"

  provisioner "local-exec" {
    command = "sleep 10"
  }

}

resource "oci_identity_tag" "ArchitectureCenterTag" {
  description      = "ArchitectureCenterTag"
  name             = "release"
  tag_namespace_id = oci_identity_tag_namespace.ArchitectureCenterTagNamespace.id

  validator {
    validator_type = "ENUM"
    values         = ["release", var.release_tag_default_value]
  }

  provisioner "local-exec" {
    command = "sleep 120"
  }
}

resource "oci_identity_tag_default" "benchmarking_tag_default" {
  compartment_id    = var.parent_compartment_id
  tag_definition_id = oci_identity_tag.ArchitectureCenterTag.id
  value             = var.release_tag_default_value
  is_required       = false
}
