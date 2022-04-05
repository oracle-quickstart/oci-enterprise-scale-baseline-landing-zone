terraform {
  required_providers {
    oci = {
      configuration_aliases = [oci, oci.home_region]
    }
  }
}

# -----------------------------------------------------------------------------
# Create Topics and Subscription
# -----------------------------------------------------------------------------
locals  {

  # Topics
  # If you have an existing topic you want to use enter the OCID(s) in the id property.
  security_topic    = {key: "SECURITY-TOPIC",   name: "${random_id.suffix.hex}-security-topic",   cmp_id: module.security-compartment.security_compartment_id, id: null}
  network_topic     = {key: "NETWORK-TOPIC",    name: "${random_id.suffix.hex}-network-topic",    cmp_id: module.network-compartment.network_compartment_id,  id: null}
  budget_topic      = {key: "BUDGET-TOPIC",     name: "${random_id.suffix.hex}-budget-topic",     cmp_id: var.tenancy_ocid, id : null }

  home_region_topics = {
    for i in [1] : (local.security_topic.key) => {
      compartment_id = local.security_topic.cmp_id
      name           = local.security_topic.name
      description    = "Landing Zone topic for security related notifications."
      freeform_tags = {
        "Description" = "Security Related Topic",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    } if local.security_topic.id == null && length(var.security_admin_email_endpoints) > 0
  }

  regional_topics = merge(
      {for i in [1] :  (local.network_topic.key) => {
        compartment_id = local.network_topic.cmp_id
        name           = local.network_topic.name
        description    = "Landing Zone topic for network related notifications."
        freeform_tags = {
          "Description" = "Network Related Topic",
          "CostCenter"  = var.tag_cost_center,
          "GeoLocation" = var.tag_geo_location
        }
      } if local.network_topic.id == null && length(var.network_admin_email_endpoints) > 0},

      {for i in [1]: (local.budget_topic.key) => {
        compartment_id = var.tenancy_ocid
        name           = local.budget_topic.name
        description    = "Landing Zone topic for budget related notifications."
        freeform_tags = {
          "Description" = "Budget Related Topic",
          "CostCenter"  = var.tag_cost_center,
          "GeoLocation" = var.tag_geo_location
        }
      } if length(var.budget_admin_email_endpoints) > 0}
  )

}

module "lz-home-region-topics" {
  source     = "./monitoring/topics"
  depends_on = [module.network-compartment, module.security-compartment]
  providers   = { oci = oci.home_region }
  topics     = local.home_region_topics
}

module "lz-topics" {
  source     = "./monitoring/topics"
  depends_on = [module.network-compartment, module.security-compartment]
  topics     = local.regional_topics
}

module "lz-home-region-subscriptions" {
  source        = "./monitoring/subscriptions"
  providers     = { oci = oci.home_region }
  subscriptions = {
    for e in var.security_admin_email_endpoints: "${e}-${local.security_topic.name}" => {
      compartment_id = local.security_topic.cmp_id
      topic_id       = local.security_topic.id != null ? local.security_topic.id : module.lz-home-region-topics.topics[local.security_topic.key].id
      protocol       = "EMAIL" # Other valid protocols: "CUSTOM_HTTPS", "PAGER_DUTY", "SLACK", "ORACLE_FUNCTIONS"
      endpoint       = e       # Protocol matching endpoints: "https://www.oracle.com", "https://your.pagerduty.endpoint.url", "https://your.slack.endpoint.url", "<function_ocid>"
      freeform_tags = {
        "Description" = "Security Admin Subscription",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    } if length(var.security_admin_email_endpoints) > 0
  }
  depends_on = [module.lz-home-region-topics]
}

module "lz-subscriptions" {
  source        = "./monitoring/subscriptions"
  subscriptions = merge(
    { for e in var.network_admin_email_endpoints: "${e}-${local.network_topic.name}" => {
      compartment_id = local.network_topic.cmp_id
      topic_id       = local.network_topic.id == null ? module.lz-topics.topics[local.network_topic.key].id : local.network_topic.id
      protocol       = "EMAIL"
      endpoint       = e
      freeform_tags = {
        "Description" = "Network Admin Subscription",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    } if length(var.network_admin_email_endpoints) > 0},

    { for e in var.budget_admin_email_endpoints: "${e}-${local.budget_topic.name}" => {
      compartment_id = local.budget_topic.cmp_id
      topic_id = local.budget_topic.id == null ? module.lz-topics.topics[local.budget_topic.key].id : local.budget_topic.id
      protocol = "EMAIL"
      endpoint = e
      freeform_tags = {
        "Description" = "Budget Admin Subscription",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    } if length(var.budget_admin_email_endpoints) > 0}
  )
  depends_on = [module.lz-topics]
}

# -----------------------------------------------------------------------------
# Create Notifications
# -----------------------------------------------------------------------------
locals {

  notify_on_iam_changes_rule     = {key:"${random_id.suffix.hex}-notify-on-iam-changes-rule",           name:"${random_id.suffix.hex}-notify-on-iam-changes-rule" }
  notify_on_network_changes_rule = {key:"${random_id.suffix.hex}-notify-on-network-changes-rule",       name:"${random_id.suffix.hex}-notify-on-network-changes-rule"}
  notify_on_budget_changes_rule  = {key:"${random_id.suffix.hex}-notify-on-budget-changes-rule",        name:"${random_id.suffix.hex}-notify-on-budget-changes-rule"}

  home_region_notifications = {
   for i in [1] :     (local.notify_on_iam_changes_rule.key) => {
      compartment_id = var.tenancy_ocid
      description    = "Landing Zone related events rule to detect when IAM resources are created, updated or deleted."
      is_enabled     = true
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
      actions_action_type = "ONS"
      actions_is_enabled  = true
      actions_description = "Sends notification via ONS"
      topic_id            = local.security_topic.id != null ? local.security_topic.id : module.lz-home-region-topics.topics[local.security_topic.key].id
      freeform_tags = {
        "Description" = "IAM Related Notifications",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    }
  }

  regional_notifications =  merge (
    {for i in [1] : (local.notify_on_network_changes_rule.key) => {
      compartment_id = var.tenancy_ocid
      description    = "Landing Zone events rule to detect when networking resources are created, updated or deleted."
      is_enabled     = true
      condition      = <<EOT
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
      actions_action_type = "ONS"
      actions_is_enabled  = true
      actions_description = "Sends notification via ONS"
      topic_id            = local.network_topic.id == null ? module.lz-topics.topics[local.network_topic.key].id : local.network_topic.id
      freeform_tags = {
        "Description" = "Network Related Notifications",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    }},


    {for i in [1] : (local.notify_on_budget_changes_rule.key) => {
      compartment_id = var.tenancy_ocid
      description    = "Landing Zone events rule to detect when cost resources such as budgets and financial tracking constructs are created, updated or deleted."
      is_enabled     = true
      condition      = <<EOT
        {"eventType":
        ["com.oraclecloud.budgets.updatealertrule",
         "com.oraclecloud.budgets.deletealertrule",
         "com.oraclecloud.budgets.updatebudget",
         "com.oraclecloud.budgets.deletebudget"
        ]
        }
        EOT
      actions_action_type = "ONS"
      actions_is_enabled  = true
      actions_description = "Sends notification via ONS"
      topic_id            = local.budget_topic.id == null ? module.lz-topics.topics[local.budget_topic.key].id : local.budget_topic.id
      freeform_tags = {
        "Description" = "Budget Related Notifications",
        "CostCenter"  = var.tag_cost_center,
        "GeoLocation" = var.tag_geo_location
      }
    } if length(var.budget_admin_email_endpoints) > 0}

  )
}

module "lz-notifications" {
  depends_on = [module.lz-subscriptions]
  source     = "./monitoring/notifications"
  rules      = local.regional_notifications
}

module "lz-home-region-notifications" {
  depends_on = [module.lz-home-region-subscriptions]
  source     = "./monitoring/notifications"
  providers   = { oci = oci.home_region }
  rules      = local.home_region_notifications
}