# -----------------------------------------------------------------------------
# Create Topics
# -----------------------------------------------------------------------------
module "security-topics" {
  source              = "./monitoring/topics/security-topic"
  compartment_id      = module.security-compartment.security_compartment_id
  security_topic_name = var.security_topic_name
  tag_geo_location    = var.tag_geo_location
  tag_cost_center     = var.tag_cost_center
  providers           = { oci = oci.home_region }
  depends_on          = [ module.security-compartment ]
  suffix              = random_id.suffix.hex
}

module "network-topics" {
  source             = "./monitoring/topics/network-topic"
  compartment_id     = module.network-compartment.network_compartment_id
  network_topic_name = var.network_topic_name
  tag_geo_location   = var.tag_geo_location
  tag_cost_center    = var.tag_cost_center
  depends_on         = [ module.network-compartment ]
  suffix             = random_id.suffix.hex
}

module "budget-topics" {
  source            = "./monitoring/topics/budget-topic"
  compartment_id    = var.tenancy_ocid
  budget_topic_name = var.budget_topic_name
  tag_geo_location  = var.tag_geo_location
  tag_cost_center   = var.tag_cost_center
  suffix            = random_id.suffix.hex
}

# -----------------------------------------------------------------------------
# Create Subscription
# -----------------------------------------------------------------------------
module "security-subscription" {
  for_each              = toset(var.security_admin_email_endpoints)
  source                = "./monitoring/subscriptions/security-subscription"
  compartment_id        = module.security-compartment.security_compartment_id
  endpoint              = each.value
  subscription_protocol = var.subscription_protocol
  tag_geo_location      = var.tag_geo_location
  tag_cost_center       = var.tag_cost_center
  topic_id              = module.security-topics.security_topic_id
  providers             = { oci = oci.home_region }
  depends_on            = [ module.security-topics ]
}

module "budget-subscription" {
  for_each              = toset(var.budget_admin_email_endpoints)
  source                = "./monitoring/subscriptions/budget-subscription"
  compartment_id        = var.tenancy_ocid
  endpoint              = each.value
  subscription_protocol = var.subscription_protocol
  tag_geo_location      = var.tag_geo_location
  tag_cost_center       = var.tag_cost_center
  topic_id              = module.budget-topics.budget_topic_id
  depends_on            = [ module.budget-topics ]
}

module "network-subscription" {
  for_each              = toset(var.network_admin_email_endpoints)
  source                = "./monitoring/subscriptions/network-subscription"
  compartment_id        = module.network-compartment.network_compartment_id
  endpoint              = each.value
  subscription_protocol = var.subscription_protocol
  tag_geo_location      = var.tag_geo_location
  tag_cost_center       = var.tag_cost_center
  topic_id              = module.network-topics.network_topic_id
  depends_on            = [ module.security-topics ]
}

# -----------------------------------------------------------------------------
# Create Notification Rules
# -----------------------------------------------------------------------------
module "iam-notifications" {
  source                          = "./monitoring/notifications/iam-notification"
  compartment_id                  = var.tenancy_ocid
  notification_action_type        = var.notification_action_type
  topic_id                        = module.security-topics.security_topic_id
  enable_iam_notification_action  = var.enable_iam_notification_action
  enable_iam_notification_rule    = var.enable_iam_notification_rule
  iam_notification_display_name   = var.iam_notification_display_name
  notification_action_description = var.notification_action_description
  iam_notification_description    = var.iam_notification_description
  tag_geo_location                = var.tag_geo_location
  tag_cost_center                 = var.tag_cost_center
  suffix                          = random_id.suffix.hex
  providers                       = { oci = oci.home_region }
  depends_on                      = [ module.security-topics ]
}

module "network-notifications" {
  source                             = "./monitoring/notifications/network-notification"
  compartment_id                     = var.tenancy_ocid
  notification_action_type           = var.notification_action_type
  topic_id                           = module.network-topics.network_topic_id
  enable_network_notification_action = var.enable_network_notification_action
  enable_network_notification_rule   = var.enable_network_notification_rule
  network_notification_display_name  = var.network_notification_display_name
  notification_action_description    = var.notification_action_description
  network_notification_description   = var.network_notification_description
  tag_geo_location                   = var.tag_geo_location
  tag_cost_center                    = var.tag_cost_center
  suffix                             = random_id.suffix.hex
  depends_on                         = [ module.network-topics ]
}

module "budget-notifications" {
  source                            = "./monitoring/notifications/budget-notification"
  compartment_id                    = var.tenancy_ocid
  notification_action_type          = var.notification_action_type
  topic_id                          = module.budget-topics.budget_topic_id
  enable_budget_notification_action = var.enable_budget_notification_action
  enable_budget_notification_rule   = var.enable_budget_notification_rule
  budget_notification_display_name  = var.budget_notification_display_name
  notification_action_description   = var.notification_action_description
  budget_notification_description   = var.budget_notification_description
  tag_geo_location                  = var.tag_geo_location
  tag_cost_center                   = var.tag_cost_center
  suffix                            = random_id.suffix.hex
  depends_on                        = [ module.budget-topics ]
}
