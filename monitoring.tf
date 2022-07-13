# -----------------------------------------------------------------------------
# Create Topics
# -----------------------------------------------------------------------------
locals {
  security_topic = {key: "SECURITY-TOPIC", name: var.security_topic_name, cmp_id: module.security-compartment.security_compartment_id}
  network_topic  = {key: "NETWORK-TOPIC", name: var.network_topic_name, cmp_id: module.network-compartment.network_compartment_id}
  budget_topic   = {key: "BUDGET-TOPIC", name: var.budget_topic_name, cmp_id: var.tenancy_ocid}

  home_region_topics = merge(
    {for i in [1] : (local.security_topic.key) => {
      compartment_id = local.security_topic.cmp_id
      name           = "${local.security_topic.name}-${random_id.suffix.hex}"
      description    = "Landing Zone topic for security related notifications."
      freeform_tags  = {
        "Description" = "Landing Zone Security Topic",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    } if length(var.security_admin_email_endpoints) > 0
    }
  )

  regional_topics = merge(
    {for i in [1] :  (local.network_topic.key) => {
      compartment_id = local.network_topic.cmp_id
      name           = "${local.network_topic.name}-${random_id.suffix.hex}"
      description    = "Landing Zone topic for network related notifications."
      freeform_tags  = {
        "Description" = "Landing Zone Network Topic",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    } if length(var.network_admin_email_endpoints) > 0},

    {for i in [1]: (local.budget_topic.key) => {
      compartment_id = local.budget_topic.cmp_id
      name           = "${local.budget_topic.name}-${random_id.suffix.hex}"
      description    = "Landing Zone topic for budget related notifications."
      freeform_tags  = {
        "Description" = "Landing Zone Budget Topic",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    } if length(var.budget_admin_email_endpoints) > 0}
  )
}

module "home-region-topics" {
  source     = "./monitoring/topics"
  topics     = local.home_region_topics
  providers  = { oci = oci.home_region }
  depends_on = [ module.security-compartment ]
}

module "regional-topics" {
  source     = "./monitoring/topics"
  depends_on = [ module.network-compartment ]
  topics     = local.regional_topics
}

# -----------------------------------------------------------------------------
# Create Subscription
# -----------------------------------------------------------------------------
module "home-region-subscriptions" {
  source        = "./monitoring/subscriptions/"
  providers  = { oci = oci.home_region }
  subscriptions = merge(
    { for e in var.security_admin_email_endpoints: "${e}-${local.security_topic.name}" => {
      compartment_id = local.security_topic.cmp_id
      topic_id       = module.home-region-topics.topics[local.security_topic.key].id
      protocol       = var.subscription_protocol
      endpoint       = e
      freeform_tags  = {
        "Description" = "Landing Zone security related subscription",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    }
    }
  )
}

module "regional-subscriptions" {
  source        = "./monitoring/subscriptions/"
  subscriptions = merge(
    { for e in var.network_admin_email_endpoints: "${e}-${local.network_topic.name}" => {
      compartment_id = local.network_topic.cmp_id
      topic_id       = module.regional-topics.topics[local.network_topic.key].id
      protocol       = var.subscription_protocol
      endpoint       = e
      freeform_tags  = {
        "Description" = "Landing Zone network related subscription",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    }},
    { for e in var.budget_admin_email_endpoints: "${e}-${local.budget_topic.name}" => {
      compartment_id = local.budget_topic.cmp_id
      topic_id = module.regional-topics.topics[local.budget_topic.key].id
      protocol = "EMAIL"
      endpoint = e
      freeform_tags  = {
        "Description" = "Landing Zone budget related subscription",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    }}
  )
}

# -----------------------------------------------------------------------------
# Create Notification Rules
# -----------------------------------------------------------------------------
locals {
  notify_on_iam_changes_rule     = {key:"notify-on-iam-changes-rule", name: var.iam_notification_display_name }
  notify_on_network_changes_rule = {key:"notify-on-network-changes-rule", name: var.network_notification_display_name}
  notify_on_budget_changes_rule  = {key:"notify-on-budget-changes-rule", name: var.budget_notification_display_name}

  home_region_notifications = merge(
    {for i in [1] :     (local.notify_on_iam_changes_rule.key) => {
      compartment_id      = var.tenancy_ocid
      description         = var.iam_notification_description
      is_enabled          = var.enable_iam_notification_rule
      display_name        = "${local.notify_on_iam_changes_rule.name}-${random_id.suffix.hex}"
      condition           = <<EOT
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
      actions_action_type = var.notification_action_type
      actions_is_enabled  = var.enable_iam_notification_action
      actions_description = var.notification_action_description
      topic_id            = module.home-region-topics.topics[local.security_topic.key].id
      freeform_tags  = {
        "Description" = "Landing Zone IAM change notification",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    }}
  )

  regional_notifications =  merge (
    {for i in [1] : (local.notify_on_network_changes_rule.key) => {
      compartment_id      = var.tenancy_ocid
      description         = var.network_notification_description
      display_name        = "${local.notify_on_network_changes_rule.name}-${random_id.suffix.hex}"
      is_enabled          = var.enable_network_notification_rule
      condition           = <<EOT
        {"eventType":
          ["com.oraclecloud.virtualnetwork.createvcn",
          "com.oraclecloud.virtualnetwork.deletevcn",
          "com.oraclecloud.virtualnetwork.updatevcn",
          "com.oraclecloud.virtualnetwork.createroutetable",
          "com.oraclecloud.virtualnetwork.deleteroutetable",
          "com.oraclecloud.virtualnetwork.updateroutetable",
          "com.oraclecloud.virtualnetwork.changeroutetablecompartment",
          "com.oraclecloud.virtualnetwork.createsecuritylist",
          "com.oraclecloud.virtualnetwork.deletesecuritylist",
          "com.oraclecloud.virtualnetwork.updatesecuritylist",
          "com.oraclecloud.virtualnetwork.changesecuritylistcompartment",
          "com.oraclecloud.virtualnetwork.createnetworksecuritygroup",
          "com.oraclecloud.virtualnetwork.deletenetworksecuritygroup",
          "com.oraclecloud.virtualnetwork.updatenetworksecuritygroup",
          "com.oraclecloud.virtualnetwork.updatenetworksecuritygroupsecurityrules",
          "com.oraclecloud.virtualnetwork.changenetworksecuritygroupcompartment",
          "com.oraclecloud.virtualnetwork.createdrg",
          "com.oraclecloud.virtualnetwork.deletedrg",
          "com.oraclecloud.virtualnetwork.updatedrg",
          "com.oraclecloud.virtualnetwork.createdrgattachment",
          "com.oraclecloud.virtualnetwork.deletedrgattachment",
          "com.oraclecloud.virtualnetwork.updatedrgattachment",
          "com.oraclecloud.virtualnetwork.createinternetgateway",
          "com.oraclecloud.virtualnetwork.deleteinternetgateway",
          "com.oraclecloud.virtualnetwork.updateinternetgateway",
          "com.oraclecloud.virtualnetwork.changeinternetgatewaycompartment",
          "com.oraclecloud.virtualnetwork.createlocalpeeringgateway",
          "com.oraclecloud.virtualnetwork.deletelocalpeeringgateway",
          "com.oraclecloud.virtualnetwork.updatelocalpeeringgateway",
          "com.oraclecloud.virtualnetwork.changelocalpeeringgatewaycompartment",
          "com.oraclecloud.natgateway.createnatgateway",
          "com.oraclecloud.natgateway.deletenatgateway",
          "com.oraclecloud.natgateway.updatenatgateway",
          "com.oraclecloud.natgateway.changenatgatewaycompartment",
          "com.oraclecloud.servicegateway.createservicegateway",
          "com.oraclecloud.servicegateway.deleteservicegateway.begin",
          "com.oraclecloud.servicegateway.deleteservicegateway.end",
          "com.oraclecloud.servicegateway.attachserviceid",
          "com.oraclecloud.servicegateway.detachserviceid",
          "com.oraclecloud.servicegateway.updateservicegateway",
          "com.oraclecloud.servicegateway.changeservicegatewaycompartment"
          ]
        }
        EOT
      actions_action_type = var.notification_action_type
      actions_is_enabled  = var.enable_network_notification_action
      actions_description = var.notification_action_description
      topic_id            = module.regional-topics.topics[local.network_topic.key].id
      freeform_tags  = {
        "Description" = "Landing Zone network change notification",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    }},

    {for i in [1] : (local.notify_on_budget_changes_rule.key) => {
      compartment_id      = var.tenancy_ocid
      description         = var.budget_notification_description
      is_enabled          = var.enable_budget_notification_rule
      display_name        = "${local.notify_on_budget_changes_rule.name}-${random_id.suffix.hex}"
      condition           = <<EOT
            {"eventType":
            ["com.oraclecloud.budgets.updatealertrule",
             "com.oraclecloud.budgets.deletealertrule",
             "com.oraclecloud.budgets.updatebudget",
             "com.oraclecloud.budgets.deletebudget"
            ]
            }
            EOT
      actions_action_type = var.notification_action_type
      actions_is_enabled  = var.enable_budget_notification_action
      actions_description = var.notification_action_description
      topic_id            = module.regional-topics.topics[local.budget_topic.key].id
      freeform_tags  = {
        "Description" = "Landing Zone budget change notification",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    }}
  )
}

module "regional-notifications" {
  depends_on = [ module.regional-topics ]
  source     = "./monitoring/notifications"
  rules      = local.regional_notifications
}

module "home-region-notifications" {
  depends_on = [ module.home-region-topics ]
  source     = "./monitoring/notifications"
  providers  = { oci = oci.home_region  }
  rules      = local.home_region_notifications
}

# -----------------------------------------------------------------------------
# Create Tags 
# -----------------------------------------------------------------------------
module "tagging" {
  source                = "./monitoring/tags/architecture-center"
  tenancy_ocid          = var.tenancy_ocid
  parent_compartment_id = module.parent-compartment.parent_compartment_id
  providers             = { oci = oci.home_region }
  depends_on            = [module.parent-compartment]
}

# -----------------------------------------------------------------------------
# Create Alarms
# -----------------------------------------------------------------------------
locals {
  network_fast_connect_status_alarm   = {key:"fast-connect-status-alarm",    name:"fast-connect-status-alarm"}

  network_alarms = merge(
    {for i in [1] : (local.network_fast_connect_status_alarm.key) => {
      compartment_id = module.network-compartment.network_compartment_id
      destinations = [ module.regional-topics.topics[local.network_topic.key].id ]
      display_name = local.network_fast_connect_status_alarm.name
      freeform_tags = local.alarms_freeform_tags
      is_enabled = var.enable_alarms
      metric_compartment_id = module.network-compartment.network_compartment_id
      namespace = "oci_fastconnect"
      query = "ConnectionState[1m].mean() == 0"
      severity = "CRITICAL"
      metric_compartment_id_in_subtree = true
      message_format = "PRETTY_JSON"
      pending_duration = "PT5M"
    } if length(var.network_admin_email_endpoints) > 0}
  )

  alarms_freeform_tags = {
    "Description" = "Landing Zone Network Alarm",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }
}

module "network-alarms" {
  source    = "./monitoring/alarms"
  depends_on = [ module.regional-subscriptions ]
  alarms = local.network_alarms
}
