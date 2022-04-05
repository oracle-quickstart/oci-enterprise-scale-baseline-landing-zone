output subscriptions {
  description = "The subscriptions, indexed by ID."
  value = {for sub in oci_ons_subscription.subscriptions : sub.id => sub}
}