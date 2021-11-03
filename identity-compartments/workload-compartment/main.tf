terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create workload compartment under parent compartment
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_compartment" "workload_compartment" {
  compartment_id  = var.common_infra_compartment_ocid
  description     = "Compartment for ${var.compartment_name} workload"
  name            = var.compartment_name
  freeform_tags = {
    "Description" = "${var.compartment_name} Workload Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

resource "time_sleep" "wait_90_seconds" {
  depends_on = [oci_identity_compartment.workload_compartment]
  create_duration = "90s"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create tagging namespace and tag default
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_tag_namespace" "workload_compartment_tag_namespace" {
  compartment_id = oci_identity_compartment.workload_compartment.id
  description    = "Tags used for all resources"
  name           = "${var.compartment_name}_tag_namespace"
}

resource "oci_identity_tag" "cost_center_tag" {
  description      = "Cost center used for budgeting and reporting."
  name             = "CostCenter"
  tag_namespace_id = oci_identity_tag_namespace.workload_compartment_tag_namespace.id
}

resource "oci_identity_tag_default" "cost_center_tag_default" {
  compartment_id    = oci_identity_compartment.workload_compartment.id
  tag_definition_id = oci_identity_tag.cost_center_tag.id
  value             = var.tag_cost_center
  is_required       = false
}

resource "oci_identity_tag" "geo_location_tag" {
  description      = "Geo location used for budgeting and reporting."
  name             = "GeoLocation"
  tag_namespace_id = oci_identity_tag_namespace.workload_compartment_tag_namespace.id
}

resource "oci_identity_tag_default" "geo_location_tag_default" {
  compartment_id    = oci_identity_compartment.workload_compartment.id
  tag_definition_id = oci_identity_tag.geo_location_tag.id
  value             = var.tag_geo_location
  is_required       = false
}