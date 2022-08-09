terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Policy Network Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "network_admin_policies" {
  compartment_id = var.network_compartment_id
  description    = "OCI Landing Zone VCN Administrator Policy"
  name           = var.network_admin_policy_name

  freeform_tags = {
    "Description" = "Policy for access to all network resources in Network Compartment",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    "Allow group ${var.network_admin_group_name} to manage virtual-network-family in compartment ${var.network_compartment_name}",
    # Ability to manage all resources in the Bastion service in all compartments
    "Allow group ${var.network_admin_group_name} to manage bastion in compartment ${var.network_compartment_name}",
    "Allow group ${var.network_admin_group_name} to manage bastion-session in compartment ${var.network_compartment_name}",
    # Access to all components in Load-balancing 
    "Allow group ${var.network_admin_group_name} to manage load-balancers in compartment ${var.network_compartment_name}"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Platform Admin Policy
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "platform_admin_policies" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Platform Admin Policy"
  name           = "${var.platform_admin_policy_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Policy for Platform Admin",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    # Ability to view usage reports for your tenancy
    "Define tenancy usage-report as ocid1.tenancy.oc1..aaaaaaaaned4fkpkisbwjlr56u7cj63lf3wffbilvqknstgtvzub7vhqkggq",
    "Endorse group ${var.platform_admin_group_name} to read objects in tenancy usage-report",
    # Ability to see costs for the tenancy.
    "Allow group ${var.platform_admin_group_name} to manage usage-report in tenancy",
    # Abililty to create, edit, and delete budgets and alerts rules.
    "Allow group ${var.platform_admin_group_name} to manage usage-budgets in tenancy",
    # Ability to view and manage financial transactions
    # use the Subscriptions, Invoices, and Payment History pages
    "Allow group ${var.platform_admin_group_name} to manage accountmanagement-family in tenancy",
    "Allow group ${var.platform_admin_group_name} to manage tickets in tenancy",
    # # Invoices usage
    # "Allow group ${var.platform_admin_group_name} to read computed-usages, invoices, subscribed-services in tenancy",
    # # Subscriptions
    # "Allow group ${var.platform_admin_group_name} to read subscription, billing-schedules, subscribed-services, rate-cards in tenancy",
    # # Invoices
    # "Allow group ${var.platform_admin_group_name} to manage invoices, invoice-preferences in tenancy",
    # # Payment History
    # "Allow group ${var.platform_admin_group_name} to manage invoices, invoice-preferences in tenancy",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Admin Policy
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "iam_admin_policies" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone IAM Admin Policy"
  name           = "${var.iam_admin_policy_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Policy for IAM Admin",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    "Allow group ${var.iam_admin_group_name} to inspect users in tenancy",
    # Users should be manage users and groups permissions via IDP
    "Allow group ${var.iam_admin_group_name} to inspect groups in tenancy",
    "Allow group ${var.iam_admin_group_name} to read policies in tenancy",
    "Allow group ${var.iam_admin_group_name} to manage groups in tenancy where all {target.group.name != 'Administrators'}",
    "Allow group ${var.iam_admin_group_name} to inspect identity-providers in tenancy",
    "Allow group ${var.iam_admin_group_name} to manage identity-providers in tenancy where any {request.operation = 'AddIdpGroupMapping', request.operation = 'DeleteIdpGroupMapping'}",
    "Allow group ${var.iam_admin_group_name} to manage dynamic-groups in tenancy",
    "Allow group ${var.iam_admin_group_name} to manage authentication-policies in tenancy",
    "Allow group ${var.iam_admin_group_name} to manage network-sources in tenancy",
    "Allow group ${var.iam_admin_group_name} to manage quota in tenancy",
    "Allow group ${var.iam_admin_group_name} to read audit-events in tenancy",
    "Allow group ${var.iam_admin_group_name} to use cloud-shell in tenancy",
    "Allow group ${var.iam_admin_group_name} to manage tag-defaults in tenancy",
    "Allow group ${var.iam_admin_group_name} to manage tag-namespaces in tenancy",
    # User can manage credentials in tenancy
    "Allow group ${var.iam_admin_group_name} to manage users in tenancy  where any {request.operation = 'ListApiKeys',request.operation = 'ListAuthTokens',request.operation = 'ListCustomerSecretKeys',request.operation = 'UploadApiKey',request.operation = 'DeleteApiKey',request.operation = 'UpdateAuthToken',request.operation = 'CreateAuthToken',request.operation = 'DeleteAuthToken',request.operation = 'CreateSecretKey',request.operation = 'UpdateCustomerSecretKey',request.operation = 'DeleteCustomerSecretKey',request.operation = 'UpdateUserCapabilities'}",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Ops Admin Policy
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "ops_admin_policies" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Ops Admin Policy"
  name           = "${var.ops_admin_policy_name}${var.suffix}"

  freeform_tags = {
    "Description" = "Policy for Ops Admin",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    # Ability to view and retrieve monitoring metrics
    "Allow group ${var.ops_admin_group_name} to read metrics in tenancy",
    # Ability to view and create alarms (with new or existing topics)
    "Allow group ${var.ops_admin_group_name} to manage alarms in tenancy",
    "Allow group ${var.ops_admin_group_name} to manage ons-topics in tenancy",
    # Ability to list, create, update, and delete subscriptions  for topics in the tenancy
    "Allow group ${var.ops_admin_group_name} to manage ons-subscriptions in tenancy",
    # Ability to read announcements in tenancy
    "Allow group ${var.ops_admin_group_name} to read announcements in tenancy",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Policies Security Admins
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_policy" "security_admins_policy" {
  compartment_id = var.security_compartment_id
  description    = "OCI Landing Zone Security Admin Policy"
  name           = var.security_admins_policy_name

  freeform_tags = {
    "Description" = "Policy for Security Admin Users",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    # Ability to associate an Object Storage bucket, Block Volume volume, File Storage file system, Kubernetes cluster, or Streaming stream pool with a specific key
    "Allow group ${var.security_admins_group_name} to use key-delegate in compartment ${var.security_compartment_name}",
    # Ability to do all things with secrets in a specific vault
    "Allow group ${var.security_admins_group_name} to manage vaults in compartment ${var.security_compartment_name}",
    "Allow group ${var.security_admins_group_name} to manage secret-family in compartment ${var.security_compartment_name}",
    # Ability to list, view, and perform cryptographic operations with all keys in compartment
    "Allow group ${var.security_admins_group_name} to manage keys in compartment ${var.security_compartment_name}",
    "Allow service blockstorage, objectstorage-${var.region}, FssOc1Prod, oke, streaming to use keys in compartment ${var.security_compartment_name}",
  ]
}

resource "oci_identity_policy" "security_admins_policy_network" {
  compartment_id = var.network_compartment_id
  description    = "OCI Landing Zone Security Admin Network Policy"
  name           = "${var.security_admins_policy_name}-Network"

  freeform_tags = {
    "Description" = "Network Policy for Security Admin Users",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    "Allow group ${var.security_admins_group_name} to manage virtual-network-family in compartment ${var.network_compartment_name}",
  ]
}

resource "random_id" "security" {
  byte_length = 4
}

resource "oci_identity_policy" "security_admins_policy_root" {
  compartment_id = var.tenancy_ocid
  description    = "OCI Landing Zone Security Admin Root Policy"
  name           = "${var.security_admins_policy_name}-Root-${random_id.security.hex}"

  freeform_tags = {
    "Description" = "Root Policy for Security Admin Users",
    "CostCenter"  = var.tag_cost_center,
    "GeoLocation" = var.tag_geo_location
  }

  statements = [
    "Allow group ${var.security_admins_group_name} to read instance-family in tenancy",
    "Allow group ${var.security_admins_group_name} to read instance-agent-plugins in tenancy",
    "Allow group ${var.security_admins_group_name} to inspect work-requests in tenancy",
    # Admin access to VSS
    "Allow group ${var.security_admins_group_name} to manage vss-family in tenancy",
    # Admin access to Cloud Guard
    "Allow group ${var.security_admins_group_name} to manage cloud-guard-family in tenancy"
  ]
}
