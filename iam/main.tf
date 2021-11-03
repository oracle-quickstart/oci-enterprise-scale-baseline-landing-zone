# ---------------------------------------------------------------------------------------------------------------------
# Create test parent compartment under root compartment
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_compartment" "test_compartment" {
  compartment_id  = var.tenancy_ocid
  description     = "test Compartment"
  name            = "${var.unique_prefix}_test"
  freeform_tags   = {
    "Description" = "test Compartment"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create group Administrators
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_group" "administrator_group" {
    compartment_id = var.tenancy_ocid
    description = "Administrator group - manages all resources"
    name = var.administrator_group_name

    # defined_tags = {"Operations.CostCenter"= "42"}
    # freeform_tags = {"Department"= "Finance"}
}

resource "oci_identity_policy" "administrator_policies" {
  compartment_id  = oci_identity_compartment.test_compartment.id
  description     = "Administrator group policies"
  name            = var.administrator_policies_name
  freeform_tags   = {
    "Description" = "Policy for access to all resources in tenancy"
  }
  statements = [
    "Allow group ${var.administrator_group_name} to manage all-resources in compartment ${var.unique_prefix}_test"
  ]
}
