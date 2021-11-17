resource "random_id" "bucket_name" {
  byte_length = 8
}

resource "oci_objectstorage_bucket" "audit_log_bucket" {
  compartment_id = var.parent_compartment_ocid
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = "${var.audit_log_bucket_name}-${random_id.bucket_name.id}"
  access_type    = "NoPublicAccess"
  storage_tier   = "Archive"

  retention_rules {
    display_name = "Audit Log Retention Rule"

    duration {
      time_amount = var.retention_rule_duration_time_amount
      time_unit   = var.retention_rule_duration_time_unit
    }

    # time_rule_locked = 
  }

  freeform_tags = {
    "Description" = "Audit Log bucket"
    "Function"    = "Object store bucket for Audit Log record"
  }
}

resource "oci_audit_configuration" "audit_configuration" {
  compartment_id        = var.tenancy_ocid
  retention_period_days = var.audit_retention_period
}

resource "oci_sch_service_connector" "audit_log_service_connector" {
  compartment_id = var.parent_compartment_ocid
  display_name   = var.service_connector_display_name
  description    = var.service_connector_description

  freeform_tags = {
    "Description" = "Service connector to transfer audit log",
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

  target {
    kind                       = var.service_connector_target_kind
    batch_rollover_size_in_mbs = var.service_connector_target_batch_rollover_size_in_mbs
    batch_rollover_time_in_ms  = var.service_connector_target_batch_rollover_time_in_ms
    bucket                     = oci_objectstorage_bucket.audit_log_bucket.name
    namespace                  = data.oci_objectstorage_namespace.ns.namespace
    object_name_prefix         = "audit-"
  }
}
