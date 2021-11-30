# ---------------------------------------------------------------------------------------------------------------------
# Random IDs to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
# resource "random_id" "policy_name" {
#   byte_length = 8
# }

resource "oci_logging_log_group" "central_log_group" {
  compartment_id = var.security_compartment_ocid
  display_name   = var.log_group_display_name
  description    = "Central Logging Group for VCN Flow logs"
  freeform_tags = {
    "Description" = "Central Logging Group"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

resource "oci_logging_log" "vcn_flow_log" {
  display_name = var.log_display_name
  log_group_id = oci_logging_log_group.central_log_group.id
  log_type     = var.log_log_type

  configuration {
    source {
      category    = var.log_configuration_source_category
      resource    = var.log_configuration_source_resource
      service     = var.log_configuration_source_service
      source_type = var.log_configuration_source_source_type
    }

    compartment_id = var.security_compartment_ocid
  }

  is_enabled         = var.is_flow_log_enabled
  # retention_duration = var.log_retention_duration
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Service Connector for Audit Logs
# ---------------------------------------------------------------------------------------------------------------------
  resource "oci_sch_service_connector" "vcn_flow_log_service_connector" {
    compartment_id = var.security_compartment_ocid
    display_name   = var.service_connector_display_name
    description    = "Service connector to transfer VCN Flow logs to Log Analytics"

    freeform_tags = {
      "Description" = "Service connector to transfer VCN flow log to Log Analytics",
      "CostCenter"  = var.tag_cost_center,
      "GeoLocation" = var.tag_geo_location
   }

    source {
      kind = var.service_connector_source_kind

      log_sources {
        compartment_id = var.parent_compartment_ocid
        log_group_id   = "_Audit"
      }
    }

#   target {
#     kind                       = var.service_connector_target_kind
#     batch_rollover_size_in_mbs = var.service_connector_target_batch_rollover_size_in_mbs
#     batch_rollover_time_in_ms  = var.service_connector_target_batch_rollover_time_in_ms
#     bucket                     = oci_objectstorage_bucket.audit_log_bucket.name
#     namespace                  = data.oci_objectstorage_namespace.ns.namespace
#   }
# }