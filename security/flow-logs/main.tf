resource "random_id" "policy_name" {
  byte_length = 8
}

# ---------------------------------------------------------------------------------------------------------------------
# Central logging group for VCN Flow Logs
# ---------------------------------------------------------------------------------------------------------------------
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

resource "oci_log_analytics_log_analytics_log_group" "log_analytics_log_group" {
  compartment_id = var.security_compartment_ocid
  display_name   = "${var.log_analytics_log_group_display_name}_${random_id.policy_name.hex}"
  namespace      = data.oci_log_analytics_namespaces.logging_analytics_namespaces.namespace_collection[0].items[0].namespace

  freeform_tags = {
    "Description" = "Central Logging Group"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# VCN Flow Logs for each subnet in the Primary VCN
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_logging_log" "vcn_flow_log" {
  for_each     = var.subnet_map
  display_name = "${var.log_display_name}-${each.key}"
  log_group_id = oci_logging_log_group.central_log_group.id
  log_type     = var.log_log_type

  configuration {
    source {
      category    = var.log_configuration_source_category
      resource    = each.value
      service     = var.log_configuration_source_service
      source_type = var.log_configuration_source_source_type
    }

    compartment_id = var.security_compartment_ocid
  }

  is_enabled         = "true"
  retention_duration = var.log_retention_duration
  freeform_tags = {
    "Description" = "VCN Flow Logs"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# Service Connector policies
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "log_analytics_policy" {
  compartment_id = var.security_compartment_ocid
  description    = "OCI Landing Zone Log Analytics Policy"
  name           = "${var.log_analytics_policy_name}-${random_id.policy_name.id}"

  freeform_tags = {
    "Description" = "Service Connector policy"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    "allow any-user to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in compartment ${var.security_compartment_name} where all {request.principal.type='serviceconnector', target.loganalytics-log-group.id='${oci_log_analytics_log_analytics_log_group.log_analytics_log_group.id}', request.principal.compartment.id='${var.security_compartment_ocid}'}",
    "allow service loganalytics to { LOG_ANALYTICS_LIFECYCLE_INSPECT, LOG_ANALYTICS_LIFECYCLE_READ } in compartment ${var.security_compartment_name}",
    "allow service loganalytics to MANAGE cloudevents-rules in compartment ${var.security_compartment_name}",
    "allow service loganalytics to INSPECT compartments in compartment ${var.security_compartment_name}",
    "allow service loganalytics to USE tag-namespaces in compartment ${var.security_compartment_name}",
    "allow service loganalytics to READ loganalytics-features-family in compartment ${var.security_compartment_name}"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Service Connector for VCN Flow Logs
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

    dynamic "log_sources" {
      for_each = oci_logging_log.vcn_flow_log
      content {
        compartment_id = var.security_compartment_ocid
        log_group_id   = oci_logging_log_group.central_log_group.id
        log_id         = log_sources.value.id
      }
    }
  }

  target {
    kind                       = var.service_connector_target_kind
    log_group_id               = oci_log_analytics_log_analytics_log_group.log_analytics_log_group.id
    batch_rollover_size_in_mbs = var.service_connector_target_batch_rollover_size_in_mbs
    batch_rollover_time_in_ms  = var.service_connector_target_batch_rollover_time_in_ms
  }
}
