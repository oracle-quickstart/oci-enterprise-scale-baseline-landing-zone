terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci, oci.home_region]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Service Connector policies
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "service_connector_policy" {
  provider       = oci.home_region
  compartment_id = var.security_compartment_ocid
  description    = "OCI Landing Zone Service Connector Policy"
  name           = var.service_connector_policy_name

  freeform_tags = {
    "Description" = "Service Connector policy"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    "Allow any-user to manage objects in compartment ${var.security_compartment_name} where all {request.principal.type='serviceconnector', target.bucket.name='${oci_objectstorage_bucket.audit_log_bucket.name}', request.principal.compartment.id='${var.security_compartment_ocid}'}"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Object storage Bucket for Audit Log
# ---------------------------------------------------------------------------------------------------------------------
resource "time_offset" "bucket_creation_timestamp" {
  offset_days = 15
}

resource "oci_objectstorage_bucket" "audit_log_bucket" {
  compartment_id = var.security_compartment_ocid
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = "${var.audit_log_bucket_name}${var.suffix}"
  access_type    = "NoPublicAccess"
  kms_key_id     = var.key_id == "PLACEHOLDER" ? "" : var.key_id
  storage_tier   = "Archive"

  retention_rules {
    display_name = "Audit Log Retention Rule"

    duration {
      time_amount = var.retention_rule_duration_time_amount
      time_unit   = var.retention_rule_duration_time_unit
    }

    time_rule_locked = time_offset.bucket_creation_timestamp.rfc3339
  }

  freeform_tags = {
    "Description" = "Audit Log bucket"
    "Function"    = "Object store bucket for Audit Log record"
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

resource "oci_audit_configuration" "audit_configuration" {
  compartment_id        = var.parent_compartment_ocid
  retention_period_days = var.audit_retention_period
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Service Connector for Audit Logs
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_sch_service_connector" "audit_log_service_connector" {
  compartment_id = var.security_compartment_ocid
  display_name   = var.service_connector_display_name
  description    = "Service connector to transfer audit log to object storage bucket"

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
  }
}
