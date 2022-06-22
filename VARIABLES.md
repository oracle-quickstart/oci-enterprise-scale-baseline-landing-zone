## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_current_user_ocid"></a> [current\_user\_ocid](#input\_current\_user\_ocid) | OCID of the current user | `string` | n/a | yes |
| <a name="input_is_sandbox_mode_enabled"></a> [is\_sandbox\_mode\_enabled](#input\_is\_sandbox\_mode\_enabled) | Do you want to run the stack in Sandbox mode? | `bool` | n/a | yes |
| <a name="input_parent_compartment_name"></a> [parent\_compartment\_name](#input\_parent\_compartment\_name) | Name of the top level / parent compartment | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | the OCI region | `string` | n/a | yes |
| <a name="input_tag_cost_center"></a> [tag\_cost\_center](#input\_tag\_cost\_center) | CostCenter tag value | `string` | n/a | yes |
| <a name="input_tag_geo_location"></a> [tag\_geo\_location](#input\_tag\_geo\_location) | GeoLocation tag value | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_vcn_dns_label"></a> [vcn\_dns\_label](#input\_vcn\_dns\_label) | VCN DNS Label | `string` | n/a | yes |
| <a name="input_administrator_group_name"></a> [administrator\_group\_name](#input\_administrator\_group\_name) | The name for the administrator group | `string` | `"Administrators"` | no |
| <a name="input_advanced_logging_option"></a> [advanced\_logging\_option](#input\_advanced\_logging\_option) | Enable or Disable VCN flow logs and/or Audit Logs. Select an option between NONE, AUDIT\_LOGS, FLOW\_LOGS or BOTH. | `string` | `"BOTH"` | no |
| <a name="input_agent_cis_benchmark_settings_scan_level"></a> [agent\_cis\_benchmark\_settings\_scan\_level](#input\_agent\_cis\_benchmark\_settings\_scan\_level) | Agent benchmarking settings scan level | `string` | `"STRICT"` | no |
| <a name="input_api_fingerprint"></a> [api\_fingerprint](#input\_api\_fingerprint) | The fingerprint of API | `string` | `""` | no |
| <a name="input_api_private_key_path"></a> [api\_private\_key\_path](#input\_api\_private\_key\_path) | The local path to the API private key | `string` | `""` | no |
| <a name="input_applications_compartment_name"></a> [applications\_compartment\_name](#input\_applications\_compartment\_name) | Name of the top level application compartment | `string` | `"Applications"` | no |
| <a name="input_bastion_client_cidr_block_allow_list"></a> [bastion\_client\_cidr\_block\_allow\_list](#input\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that bastion is allowed to connect | `list(string)` | `[]` | no |
| <a name="input_bastion_subnet_cidr_block"></a> [bastion\_subnet\_cidr\_block](#input\_bastion\_subnet\_cidr\_block) | CIDR Block for bastion subnet | `string` | `""` | no |
| <a name="input_break_glass_user_email_list"></a> [break\_glass\_user\_email\_list](#input\_break\_glass\_user\_email\_list) | Unique list of break glass user email addresses that do not exist in the tenancy. These users are added to the Administrator group. | `list(string)` | `[]` | no |
| <a name="input_budget_admin_email_endpoints"></a> [budget\_admin\_email\_endpoints](#input\_budget\_admin\_email\_endpoints) | List of email addresses for all budget related notifications. | `list(string)` | `[]` | no |
| <a name="input_budget_alert_rule_message"></a> [budget\_alert\_rule\_message](#input\_budget\_alert\_rule\_message) | (Optional if using budget alerts): The alert message for budget alerts. | `string` | `"Default budget alert"` | no |
| <a name="input_budget_alert_rule_recipients"></a> [budget\_alert\_rule\_recipients](#input\_budget\_alert\_rule\_recipients) | (Required if using budget alerts): Target email address for budget alerts | `string` | `""` | no |
| <a name="input_budget_alert_rule_threshold"></a> [budget\_alert\_rule\_threshold](#input\_budget\_alert\_rule\_threshold) | (Required if using budget alerts): The target spending threshold for the budget | `string` | `""` | no |
| <a name="input_budget_alerting"></a> [budget\_alerting](#input\_budget\_alerting) | Set to true to enable budget alerting | `bool` | `false` | no |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | (Required if using budget alerts): The amount of the budget expressed as a number in the currency of the customer's rate card. | `string` | `""` | no |
| <a name="input_budget_notification_description"></a> [budget\_notification\_description](#input\_budget\_notification\_description) | Details of the budget notification rule | `string` | `"Events rule to detect when budget resources are created, updated or deleted"` | no |
| <a name="input_budget_notification_display_name"></a> [budget\_notification\_display\_name](#input\_budget\_notification\_display\_name) | the display name of budget notification rule | `string` | `"Budget-Change-Notification"` | no |
| <a name="input_budget_topic_name"></a> [budget\_topic\_name](#input\_budget\_topic\_name) | The name of budget topic | `string` | `"Budget-Topic"` | no |
| <a name="input_common_infra_compartment_name"></a> [common\_infra\_compartment\_name](#input\_common\_infra\_compartment\_name) | Name of the common infrastructure compartment | `string` | `"Common-Infra"` | no |
| <a name="input_cpe_ip_address"></a> [cpe\_ip\_address](#input\_cpe\_ip\_address) | Customer Premises Equipment IP address | `string` | `""` | no |
| <a name="input_deploy_global_resources"></a> [deploy\_global\_resources](#input\_deploy\_global\_resources) | Whether to deploy global resources, including tenancy level IAM service and Security service (Cloud Guard, VSS, Flow Log). Choose false if extend your Landing Zone to another region. | `bool` | `true` | no |
| <a name="input_enable_budget_notification_action"></a> [enable\_budget\_notification\_action](#input\_enable\_budget\_notification\_action) | Whether or not the budget notification action is currently enabled | `bool` | `true` | no |
| <a name="input_enable_budget_notification_rule"></a> [enable\_budget\_notification\_rule](#input\_enable\_budget\_notification\_rule) | Whether or not the budget rule is currently enabled | `bool` | `true` | no |
| <a name="input_enable_iam_notification_action"></a> [enable\_iam\_notification\_action](#input\_enable\_iam\_notification\_action) | Whether or not the iam notification action is currently enabled | `bool` | `true` | no |
| <a name="input_enable_iam_notification_rule"></a> [enable\_iam\_notification\_rule](#input\_enable\_iam\_notification\_rule) | Whether or not the iam rule is currently enabled | `bool` | `true` | no |
| <a name="input_enable_network_notification_action"></a> [enable\_network\_notification\_action](#input\_enable\_network\_notification\_action) | Whether or not the network notification action is currently enabled | `bool` | `true` | no |
| <a name="input_enable_network_notification_rule"></a> [enable\_network\_notification\_rule](#input\_enable\_network\_notification\_rule) | Whether or not the network rule is currently enabled | `bool` | `true` | no |
| <a name="input_external_subnet_ocids"></a> [external\_subnet\_ocids](#input\_external\_subnet\_ocids) | OCIDs of subnets created outside of this stack to be tracked in the VCN Flow Log service | `list(string)` | `[]` | no |
| <a name="input_fastconnect_provider"></a> [fastconnect\_provider](#input\_fastconnect\_provider) | Available FastConnect providers: AT&T, Microsoft Azure, Megaport, QTS, CEintro, Cologix, CoreSite, Digitial Realty, EdgeConneX, Epsilon, Equinix, InterCloud, Lumen, Neutrona, OMCS, OracleL2ItegDeployment, OracleL3ItegDeployment, Orange, Verizon, Zayo | `string` | `""` | no |
| <a name="input_fastconnect_routing_policy"></a> [fastconnect\_routing\_policy](#input\_fastconnect\_routing\_policy) | Available FastConnect routing policies: ORACLE\_SERVICE\_NETWORK, REGIONAL, MARKET\_LEVEL, GLOBAL | `list(string)` | `[]` | no |
| <a name="input_host_scan_recipe_agent_settings_scan_level"></a> [host\_scan\_recipe\_agent\_settings\_scan\_level](#input\_host\_scan\_recipe\_agent\_settings\_scan\_level) | Vulnerability scanning service agent scan level | `string` | `"STANDARD"` | no |
| <a name="input_host_scan_recipe_port_settings_scan_level"></a> [host\_scan\_recipe\_port\_settings\_scan\_level](#input\_host\_scan\_recipe\_port\_settings\_scan\_level) | Vulnerability scanning service port scan level | `string` | `"STANDARD"` | no |
| <a name="input_iam_admin_group_name"></a> [iam\_admin\_group\_name](#input\_iam\_admin\_group\_name) | The name for the IAM Admin group | `string` | `"IAM-Admins"` | no |
| <a name="input_iam_notification_description"></a> [iam\_notification\_description](#input\_iam\_notification\_description) | Details of the iam notification rule | `string` | `"Events rule to detect when IAM resources are created, updated or deleted"` | no |
| <a name="input_iam_notification_display_name"></a> [iam\_notification\_display\_name](#input\_iam\_notification\_display\_name) | the display name of iam notification rule | `string` | `"Iam-Change-Notification"` | no |
| <a name="input_ip_sec_connection_static_routes"></a> [ip\_sec\_connection\_static\_routes](#input\_ip\_sec\_connection\_static\_routes) | IPSec connection static routes | `list(string)` | `[]` | no |
| <a name="input_is_cloud_guard_enabled"></a> [is\_cloud\_guard\_enabled](#input\_is\_cloud\_guard\_enabled) | the status of the Cloud Guard tenant (ENABLED if true or DISABLED if false) | `bool` | `true` | no |
| <a name="input_is_shared_services_subnet_enabled"></a> [is\_shared\_services\_subnet\_enabled](#input\_is\_shared\_services\_subnet\_enabled) | Do you want to provision a private shared services subnet? | `bool` | `true` | no |
| <a name="input_is_vulnerability_scanning_service_enabled"></a> [is\_vulnerability\_scanning\_service\_enabled](#input\_is\_vulnerability\_scanning\_service\_enabled) | the status of the vulnerability scanning service | `bool` | `true` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | Encryption key OCID for security admin policy and audit bucket | `string` | `"PLACEHOLDER"` | no |
| <a name="input_network_admin_email_endpoints"></a> [network\_admin\_email\_endpoints](#input\_network\_admin\_email\_endpoints) | List of email addresses for all network related notifications. | `list(string)` | `[]` | no |
| <a name="input_network_admin_group_name"></a> [network\_admin\_group\_name](#input\_network\_admin\_group\_name) | The name for the network administrator group name | `string` | `"Virtual-Network-Admins"` | no |
| <a name="input_network_compartment_name"></a> [network\_compartment\_name](#input\_network\_compartment\_name) | Name of the top level network compartment | `string` | `"Network"` | no |
| <a name="input_network_notification_description"></a> [network\_notification\_description](#input\_network\_notification\_description) | Details of the network notification rule | `string` | `"Events rule to detect when network resources are created, updated or deleted"` | no |
| <a name="input_network_notification_display_name"></a> [network\_notification\_display\_name](#input\_network\_notification\_display\_name) | the display name of network notification rule | `string` | `"Network-Change-Notification"` | no |
| <a name="input_network_topic_name"></a> [network\_topic\_name](#input\_network\_topic\_name) | The name of network topic | `string` | `"Network-Topic"` | no |
| <a name="input_notification_action_description"></a> [notification\_action\_description](#input\_notification\_action\_description) | The details of the action | `string` | `"Sends notification via ONS"` | no |
| <a name="input_notification_action_type"></a> [notification\_action\_type](#input\_notification\_action\_type) | The action to perform if the condition in the rule matches an event. Available options: ONS, OSS, FAAS | `string` | `"ONS"` | no |
| <a name="input_ops_admin_group_name"></a> [ops\_admin\_group\_name](#input\_ops\_admin\_group\_name) | The name for the Ops Admin group | `string` | `"Ops-Admins"` | no |
| <a name="input_platform_admin_group_name"></a> [platform\_admin\_group\_name](#input\_platform\_admin\_group\_name) | The name for the Platform Admin group | `string` | `"Platform-Admins"` | no |
| <a name="input_provider_service_key_name"></a> [provider\_service\_key\_name](#input\_provider\_service\_key\_name) | The provider service key that the provider gives you when you set up a virtual circuit connection from the provider to OCI | `string` | `""` | no |
| <a name="input_retention_rule_duration_time_amount"></a> [retention\_rule\_duration\_time\_amount](#input\_retention\_rule\_duration\_time\_amount) | “Please note this feature is irreversible after 14 days.<br>        Please review (and/or) unlock the retention rule before it is locked permanently.<br>        By enabling this feature, logs will be archived in an immutable storage with locked retention rule avoiding object modification and deletion.<br>        After the rule is locked, only increase in the retention is allowed” | `string` | `1` | no |
| <a name="input_security_admin_email_endpoints"></a> [security\_admin\_email\_endpoints](#input\_security\_admin\_email\_endpoints) | List of email addresses for all security related notifications. | `list(string)` | `[]` | no |
| <a name="input_security_admins_group_name"></a> [security\_admins\_group\_name](#input\_security\_admins\_group\_name) | The name of the security admin group | `string` | `"Security-Admins"` | no |
| <a name="input_security_compartment_name"></a> [security\_compartment\_name](#input\_security\_compartment\_name) | Name of the top level security compartment | `string` | `"Security"` | no |
| <a name="input_security_topic_name"></a> [security\_topic\_name](#input\_security\_topic\_name) | The name of security topic | `string` | `"Security-Topic"` | no |
| <a name="input_shared_service_subnet_cidr_block"></a> [shared\_service\_subnet\_cidr\_block](#input\_shared\_service\_subnet\_cidr\_block) | Shared Service Subnet CIDR Block | `string` | `""` | no |
| <a name="input_shared_service_subnet_dns_label"></a> [shared\_service\_subnet\_dns\_label](#input\_shared\_service\_subnet\_dns\_label) | Shared Service Subnet DNS Label | `string` | `""` | no |
| <a name="input_subscription_protocol"></a> [subscription\_protocol](#input\_subscription\_protocol) | The protocol used for the subscription | `string` | `"EMAIL"` | no |
| <a name="input_use_fastconnect_drg"></a> [use\_fastconnect\_drg](#input\_use\_fastconnect\_drg) | Do you want to deploy the fastconnect connectivity option? (true/false) | `bool` | `false` | no |
| <a name="input_use_ipsec_drg"></a> [use\_ipsec\_drg](#input\_use\_ipsec\_drg) | Do you want to deploy the ipsec connectivity option? (true/false) | `bool` | `false` | no |
| <a name="input_vault_id"></a> [vault\_id](#input\_vault\_id) | Vault OCID for security admin policy | `string` | `"PLACEHOLDER"` | no |
| <a name="input_vcn_cidr_block"></a> [vcn\_cidr\_block](#input\_vcn\_cidr\_block) | Primary VCN CIDR Block | `string` | `"10.0.0.0/16"` | no |
| <a name="input_virtual_circuit_bandwidth_shape"></a> [virtual\_circuit\_bandwidth\_shape](#input\_virtual\_circuit\_bandwidth\_shape) | The provisioned data rate of the connection | `string` | `""` | no |
| <a name="input_virtual_circuit_cross_connect_mappings_customer_bgp_peering_ip"></a> [virtual\_circuit\_cross\_connect\_mappings\_customer\_bgp\_peering\_ip](#input\_virtual\_circuit\_cross\_connect\_mappings\_customer\_bgp\_peering\_ip) | This is the BGP IPv4 address of the customer's router | `string` | `""` | no |
| <a name="input_virtual_circuit_cross_connect_mappings_customer_secondary_bgp_peering_ip"></a> [virtual\_circuit\_cross\_connect\_mappings\_customer\_secondary\_bgp\_peering\_ip](#input\_virtual\_circuit\_cross\_connect\_mappings\_customer\_secondary\_bgp\_peering\_ip) | This is the secondary BGP IPv4 address of the customer's router | `string` | `""` | no |
| <a name="input_virtual_circuit_cross_connect_mappings_oracle_bgp_peering_ip"></a> [virtual\_circuit\_cross\_connect\_mappings\_oracle\_bgp\_peering\_ip](#input\_virtual\_circuit\_cross\_connect\_mappings\_oracle\_bgp\_peering\_ip) | IPv4 address for Oracle's end of the BGP session | `string` | `""` | no |
| <a name="input_virtual_circuit_cross_connect_mappings_oracle_secondary_bgp_peering_ip"></a> [virtual\_circuit\_cross\_connect\_mappings\_oracle\_secondary\_bgp\_peering\_ip](#input\_virtual\_circuit\_cross\_connect\_mappings\_oracle\_secondary\_bgp\_peering\_ip) | Secondary IPv4 address for Oracle's end of the BGP session | `string` | `""` | no |
| <a name="input_virtual_circuit_customer_asn"></a> [virtual\_circuit\_customer\_asn](#input\_virtual\_circuit\_customer\_asn) | The BGP ASN of the network at the other end of the BGP session from Oracle | `number` | `0` | no |
| <a name="input_vss_scan_schedule"></a> [vss\_scan\_schedule](#input\_vss\_scan\_schedule) | Vulnerability scanning service scan schedule | `string` | `"DAILY"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compartments_map"></a> [compartments\_map](#output\_compartments\_map) | Map of the compartments ocids |
| <a name="output_more_info_url"></a> [more\_info\_url](#output\_more\_info\_url) | For more information, please see the Cloud Adoption Framework - Technical Implementation |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | NAT Gateway ocid |
| <a name="output_subnet_map"></a> [subnet\_map](#output\_subnet\_map) | Subnet list mapped to display name |
| <a name="output_vcn_id"></a> [vcn\_id](#output\_vcn\_id) | VCN ocid |
