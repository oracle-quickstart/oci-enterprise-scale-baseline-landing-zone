resource "oci_cloud_guard_cloud_guard_configuration" "tenancy_cloud_guard_configuration" {
  compartment_id   = var.parent_compartment_ocid
  reporting_region = var.region
  status           = var.cloud_guard_configuration_status
}

resource "oci_cloud_guard_detector_recipe" "cloud_guard_configuration_detector_recipe" {
    compartment_id = var.parent_compartment_ocid
    display_name   = var.configuration_detector_recipe_display_name
    source_detector_recipe_id = data.oci_cloud_guard_detector_recipes.configuration_detector_recipe.id

    #Optional
    description = var.detector_recipe_description
    detector_rules {
        #Required
        details {
            #Required
            is_enabled = var.detector_recipe_detector_rules_details_is_enabled
            risk_level = var.detector_recipe_detector_rules_details_risk_level

            #Optional
            condition = var.detector_recipe_detector_rules_details_condition
            configurations {
                #Required
                config_key = var.detector_recipe_detector_rules_details_configurations_config_key
                name = var.detector_recipe_detector_rules_details_configurations_name

                #Optional
                data_type = var.detector_recipe_detector_rules_details_configurations_data_type
                value = var.detector_recipe_detector_rules_details_configurations_value
                values {
                    #Required
                    list_type = var.detector_recipe_detector_rules_details_configurations_values_list_type
                    managed_list_type = var.detector_recipe_detector_rules_details_configurations_values_managed_list_type
                    value = var.detector_recipe_detector_rules_details_configurations_values_value
                }
            }
            labels = var.detector_recipe_detector_rules_details_labels
        }
        detector_rule_id = oci_events_rule.test_rule.id
    }
    freeform_tags = {
        "Description" = "Cloud guard configuration detector recipe"
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
    }
}

resource "oci_cloud_guard_detector_recipe" "cloud_guard_activity_detector_recipe" {
    compartment_id = var.parent_compartment_ocid
    display_name   = var.activity_detector_recipe_display_name
    source_detector_recipe_id = data.oci_cloud_guard_detector_recipes.activity_detector_recipe.id

    #Optional
    description = var.detector_recipe_description
    detector_rules {
        #Required
        details {
            #Required
            is_enabled = var.detector_recipe_detector_rules_details_is_enabled
            risk_level = var.detector_recipe_detector_rules_details_risk_level

            #Optional
            condition = var.detector_recipe_detector_rules_details_condition
            configurations {
                #Required
                config_key = var.detector_recipe_detector_rules_details_configurations_config_key
                name = var.detector_recipe_detector_rules_details_configurations_name

                #Optional
                data_type = var.detector_recipe_detector_rules_details_configurations_data_type
                value = var.detector_recipe_detector_rules_details_configurations_value
                values {
                    #Required
                    list_type = var.detector_recipe_detector_rules_details_configurations_values_list_type
                    managed_list_type = var.detector_recipe_detector_rules_details_configurations_values_managed_list_type
                    value = var.detector_recipe_detector_rules_details_configurations_values_value
                }
            }
            labels = var.detector_recipe_detector_rules_details_labels
        }
        detector_rule_id = oci_events_rule.test_rule.id
    }
    freeform_tags = {
        "Description" = "Cloud guard activity detector recipe"
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
    }
}
