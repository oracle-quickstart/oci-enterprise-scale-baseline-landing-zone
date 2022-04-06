# -----------------------------------------------------------------------------
# Create Topics
# -----------------------------------------------------------------------------
module "security-topics" {
  source                  = "./monitoring/topics/security-topic"
  compartment_id          = module.security-compartment.security_compartment_id
  security_topic_name     = var.security_topic_name
  tag_geo_location        = var.tag_geo_location
  tag_cost_center         = var.tag_cost_center
  providers               = { oci = oci.home_region }
  depends_on              = [ module.security-compartment ]
}

module "network-topics" {
  source                 = "./monitoring/topics/network-topic"
  compartment_id         = module.network-compartment.network_compartment_id
  network_topic_name     = var.network_topic_name
  tag_geo_location       = var.tag_geo_location
  tag_cost_center        = var.tag_cost_center
  depends_on             = [ module.network-compartment ]
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
  source                = "./monitoring/subscription/security-subscription"
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
  source                = "./monitoring/subscription/budget-subscription"
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
  source                = "./monitoring/subscription/network-subscription"
  compartment_id        = module.network-compartment.network_compartment_id
  endpoint              = each.value
  subscription_protocol = var.subscription_protocol
  tag_geo_location      = var.tag_geo_location
  tag_cost_center       = var.tag_cost_center
  topic_id              = module.network-topics.network_topic_id
  providers             = { oci = oci.home_region }
  depends_on            = [ module.security-topics ]
}

