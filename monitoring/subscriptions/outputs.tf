output subscriptions {
  description = "The subscriptions, indexed by ID."
  value = {for sub in oci_ons_subscription.subscription_service : sub.id => sub}
}