# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies for Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "administrator_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Administrators group - manages all resources"
  name           = "${var.unique_prefix}_${var.administrator_group_name}"
}

resource "oci_identity_policy" "administrator_policies" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Administrator Tenancy Policy"
  name           = var.administrator_policy_name
  freeform_tags = {
    "Description" = "Policy for access to all resources in tenancy"
  }
  statements = [
    "Allow group ${var.administrator_group_name} to manage all-resources in tenancy"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group and Policies Network Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "network_admin_group" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Network Administrators Group - manages all network resources"
  name           = "${var.unique_prefix}_${var.network_admin_group_name}"
}

resource "oci_identity_policy" "network_admin_policies" {
  compartment_id = var.root_compartment_id
  description    = "OCI Landing Zone VCN Administrator Policy"
  name           = var.network_admin_policy_name
  freeform_tags = {
    "Description" = "Policy for access to all network resources in Network Compartment"
  }
  statements = [
    "Allow group ${var.network_admin_group_name} to manage virtual-network-family in compartment ${var.network_compartment_name}"
  ]
}
