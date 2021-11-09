resource "oci_cloud_guard_cloud_guard_configuration" "tenancy_cloud_guard_configuration" {
  compartment_id   = var.parent_compartment_ocid
  reporting_region = var.region
  status           = var.cloud_guard_configuration_status
}

resource "oci_identity_policy" "cloud_guard_policy" {
  compartment_id = var.parent_compartment_ocid
  description    = "OCI Landing Zone Cloud Guard Policy"
  name           = "Cloud Guard Policy"

  statements = [
    "allow service cloudguard to read keys in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read compartments in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read compute-management-family in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read instance-family in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read virtual-network-family in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read volume-family in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read tenancies in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read audit-events in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read vaults in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read object-family in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read load-balancers in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read object-family in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read groups in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read dynamic-groups in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read users in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read database-family in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read authentication-policies in tenancy ${var.parent_compartment_ocid}",
    "allow service cloudguard to read policies in tenancy ${var.parent_compartment_ocid}"
  ]

  freeform_tags = {
    "Description" = "Cloud guard activity detector recipe"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}
