data "oci_cloud_guard_detector_recipes" "configuration_detector_recipe" {
  compartment_id = var.tenancy_ocid
  display_name   = var.configuration_detector_recipe_display_name
}

data "oci_cloud_guard_detector_recipes" "activity_detector_recipe" {
  compartment_id = var.tenancy_ocid
  display_name   = var.activity_detector_recipe_display_name
}
