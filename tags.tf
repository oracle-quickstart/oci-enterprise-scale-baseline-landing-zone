resource "random_id" "tag" {
  byte_length = 2
}

resource "oci_identity_tag_namespace" "ArchitectureCenterTagNamespace" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  description    = "ArchitectureCenterTagNamespace"
  name           = "ArchitectureCenter\\oci-enterprise-scale-baseline-landing-zone-${random_id.tag.hex}"

  provisioner "local-exec" {
    command = "sleep 10"
  }

}

resource "oci_identity_tag" "ArchitectureCenterTag" {
  provider         = oci.home_region
  description      = "ArchitectureCenterTag"
  name             = "release"
  tag_namespace_id = oci_identity_tag_namespace.ArchitectureCenterTagNamespace.id

  validator {
    validator_type = "ENUM"
    values         = ["release", "1.0.0"]
  }

  provisioner "local-exec" {
    command = "sleep 120"
  }
}

resource "oci_identity_tag_default" "benchmarking_tag_default" {
  compartment_id    = module.parent-compartment.parent_compartment_id
  tag_definition_id = oci_identity_tag.ArchitectureCenterTag.id
  value             = "1.0.0"
  is_required       = false
}
