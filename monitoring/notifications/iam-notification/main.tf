resource "oci_events_rule" "iam_notification" {
  actions {
    actions {
      action_type = var.notification_action_type
      is_enabled  = var.enable_iam_notification_action
      description = var.notification_action_description
      topic_id    = var.topic_id
    }
  }
  compartment_id = var.compartment_id
  condition      = <<EOT
    {"eventType":
    ["com.oraclecloud.identitycontrolplane.createidentityprovider",
    "com.oraclecloud.identitycontrolplane.deleteidentityprovider",
    "com.oraclecloud.identitycontrolplane.updateidentityprovider",
    "com.oraclecloud.identitycontrolplane.createidpgroupmapping",
    "com.oraclecloud.identitycontrolplane.deleteidpgroupmapping",
    "com.oraclecloud.identitycontrolplane.updateidpgroupmapping",
    "com.oraclecloud.identitycontrolplane.addusertogroup",
    "com.oraclecloud.identitycontrolplane.creategroup",
    "com.oraclecloud.identitycontrolplane.deletegroup",
    "com.oraclecloud.identitycontrolplane.removeuserfromgroup",
    "com.oraclecloud.identitycontrolplane.updategroup",
    "com.oraclecloud.identitycontrolplane.createpolicy",
    "com.oraclecloud.identitycontrolplane.deletepolicy",
    "com.oraclecloud.identitycontrolplane.updatepolicy",
    "com.oraclecloud.identitycontrolplane.createuser",
    "com.oraclecloud.identitycontrolplane.deleteuser",
    "com.oraclecloud.identitycontrolplane.updateuser",
    "com.oraclecloud.identitycontrolplane.updateusercapabilities",
    "com.oraclecloud.identitycontrolplane.updateuserstate"]
    }
    EOT
  display_name = "${var.iam_notification_display_name}-${var.suffix}"
  is_enabled   = var.enable_iam_notification_rule
  description  = var.iam_notification_description
  freeform_tags  = {
    "Description" = "Landing Zone IAM related events rules.",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}