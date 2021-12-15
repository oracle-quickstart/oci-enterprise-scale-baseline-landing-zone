## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_client_cidr_block_allow_list"></a> [bastion\_client\_cidr\_block\_allow\_list](#input\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that bastion is allowed to connect | `list(string)` | n/a | yes |
| <a name="input_bastion_subnet_cidr_block"></a> [bastion\_subnet\_cidr\_block](#input\_bastion\_subnet\_cidr\_block) | CIDR Block for bastion subnet | `string` | n/a | yes |
| <a name="input_current_user_ocid"></a> [current\_user\_ocid](#input\_current\_user\_ocid) | OCID of the current user | `string` | n/a | yes |
| <a name="input_database_subnet_cidr_blocks"></a> [database\_subnet\_cidr\_blocks](#input\_database\_subnet\_cidr\_blocks) | List of Database Subnet CIDR Block (one per workload) | `list(string)` | n/a | yes |
| <a name="input_database_subnet_dns_labels"></a> [database\_subnet\_dns\_labels](#input\_database\_subnet\_dns\_labels) | List of Database Subnet DNS Label (one per workload) | `list(string)` | n/a | yes |
| <a name="input_is_cloud_guard_enabled"></a> [is\_cloud\_guard\_enabled](#input\_is\_cloud\_guard\_enabled) | the status of the Cloud Guard tenant (ENABLED if true or DISABLED if false) | `bool` | n/a | yes |
| <a name="input_parent_compartment_name"></a> [parent\_compartment\_name](#input\_parent\_compartment\_name) | Name of the top level / parent compartment | `string` | n/a | yes |
| <a name="input_private_subnet_cidr_blocks"></a> [private\_subnet\_cidr\_blocks](#input\_private\_subnet\_cidr\_blocks) | List of Private Subnet CIDR Block (one per workload) | `list(string)` | n/a | yes |
| <a name="input_private_subnet_dns_labels"></a> [private\_subnet\_dns\_labels](#input\_private\_subnet\_dns\_labels) | List of Private Subnet DNS Label (one per workload) | `list(string)` | n/a | yes |
| <a name="input_public_subnet_cidr_block"></a> [public\_subnet\_cidr\_block](#input\_public\_subnet\_cidr\_block) | Public Subnet CIDR Block | `string` | n/a | yes |
| <a name="input_public_subnet_dns_label"></a> [public\_subnet\_dns\_label](#input\_public\_subnet\_dns\_label) | Public Subnet DNS Label | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | the OCI region | `string` | n/a | yes |
| <a name="input_shared_service_subnet_cidr_block"></a> [shared\_service\_subnet\_cidr\_block](#input\_shared\_service\_subnet\_cidr\_block) | Shared Service Subnet CIDR Block | `string` | n/a | yes |
| <a name="input_shared_service_subnet_dns_label"></a> [shared\_service\_subnet\_dns\_label](#input\_shared\_service\_subnet\_dns\_label) | Shared Service Subnet DNS Label | `string` | n/a | yes |
| <a name="input_tag_cost_center"></a> [tag\_cost\_center](#input\_tag\_cost\_center) | CostCenter tag value | `string` | n/a | yes |
| <a name="input_tag_geo_location"></a> [tag\_geo\_location](#input\_tag\_geo\_location) | GeoLocation tag value | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_vcn_dns_label"></a> [vcn\_dns\_label](#input\_vcn\_dns\_label) | VCN DNS Label | `string` | n/a | yes |
| <a name="input_workload_compartment_names"></a> [workload\_compartment\_names](#input\_workload\_compartment\_names) | List of application workload compartment names | `list(string)` | n/a | yes |
| <a name="input_administrator_group_name"></a> [administrator\_group\_name](#input\_administrator\_group\_name) | The name for the administrator group | `string` | `"Administrators"` | no |
| <a name="input_agent_cis_benchmark_settings_scan_level"></a> [agent\_cis\_benchmark\_settings\_scan\_level](#input\_agent\_cis\_benchmark\_settings\_scan\_level) | Agent bechamrking settings scan level | `string` | `"STRICT"` | no |
| <a name="input_api_fingerprint"></a> [api\_fingerprint](#input\_api\_fingerprint) | The fingerprint of API | `string` | `""` | no |
| <a name="input_api_private_key_path"></a> [api\_private\_key\_path](#input\_api\_private\_key\_path) | The local path to the API private key | `string` | `""` | no |
| <a name="input_applications_compartment_name"></a> [applications\_compartment\_name](#input\_applications\_compartment\_name) | Name of the top level application compartment | `string` | `"applications"` | no |
| <a name="input_break_glass_user_email_list"></a> [break\_glass\_user\_email\_list](#input\_break\_glass\_user\_email\_list) | Unique list of break glass user email addresses that do not exist in the tenancy | `list(string)` | `[]` | no |
| <a name="input_budget_alert_rule_message"></a> [budget\_alert\_rule\_message](#input\_budget\_alert\_rule\_message) | (Optional if using budget alerts): The alert message for budget alerts. | `string` | `"Default budget alert"` | no |
| <a name="input_budget_alert_rule_recipients"></a> [budget\_alert\_rule\_recipients](#input\_budget\_alert\_rule\_recipients) | (Required if using budget alerts): Target email address for budget alerts | `string` | `""` | no |
| <a name="input_budget_alert_rule_threshold"></a> [budget\_alert\_rule\_threshold](#input\_budget\_alert\_rule\_threshold) | (Required if using budget alerts): The target spending threshold for the budget | `string` | `""` | no |
| <a name="input_budget_alerting"></a> [budget\_alerting](#input\_budget\_alerting) | Set to true to enable budget alerting | `bool` | `false` | no |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | (Required if using budget alerts): The amount of the budget expressed as a number in the currency of the customer's rate card. | `string` | `""` | no |
| <a name="input_cloud_guard_analysts_group_name"></a> [cloud\_guard\_analysts\_group\_name](#input\_cloud\_guard\_analysts\_group\_name) | The name of the Cloud Guard Analyst group | `string` | `"CloudGuard-Analyst"` | no |
| <a name="input_cloud_guard_architects_group_name"></a> [cloud\_guard\_architects\_group\_name](#input\_cloud\_guard\_architects\_group\_name) | The name for the Cloud Guard Architect group name | `string` | `"CloudGuard-Architect"` | no |
| <a name="input_cloud_guard_operators_group_name"></a> [cloud\_guard\_operators\_group\_name](#input\_cloud\_guard\_operators\_group\_name) | The name for the Cloud Guard Operator group name | `string` | `"CloudGuard-Operator"` | no |
| <a name="input_common_infra_compartment_name"></a> [common\_infra\_compartment\_name](#input\_common\_infra\_compartment\_name) | Name of the common infrastructure compartment | `string` | `"common-infra"` | no |
| <a name="input_cpe_ip_address"></a> [cpe\_ip\_address](#input\_cpe\_ip\_address) | Customer Premises Equipment IP address | `string` | `""` | no |
| <a name="input_egress_rules_map"></a> [egress\_rules\_map](#input\_egress\_rules\_map) | [Workload Security List] Egress Rules Map | <pre>map(object({<br>    egress_security_rules_tcp_options_destination_port_range_max = number<br>    egress_security_rules_tcp_options_destination_port_range_min = number<br>    egress_security_rules_tcp_options_source_port_range_max      = number<br>    egress_security_rules_tcp_options_source_port_range_min      = number<br>  }))</pre> | `{}` | no |
| <a name="input_fastconnect_provider"></a> [fastconnect\_provider](#input\_fastconnect\_provider) | Available FastConnect providers: AT&T, Microsoft Azure, Megaport, QTS, CEintro, Cologix, CoreSite, Digitial Realty, EdgeConneX, Epsilon, Equinix, InterCloud, Lumen, Neutrona, OMCS, OracleL2ItegDeployment, OracleL3ItegDeployment, Orange, Verizon, Zayo | `string` | `""` | no |
| <a name="input_fastconnect_routing_policy"></a> [fastconnect\_routing\_policy](#input\_fastconnect\_routing\_policy) | Availible FastConnect routing policies: ORACLE\_SERVICE\_NETWORK, REGIONAL, MARKET\_LEVEL, GLOBAL | `list(string)` | `[]` | no |
| <a name="input_host_scan_recipe_agent_settings_scan_level"></a> [host\_scan\_recipe\_agent\_settings\_scan\_level](#input\_host\_scan\_recipe\_agent\_settings\_scan\_level) | Vulnerability scanning service agent scan level | `string` | `"STANDARD"` | no |
| <a name="input_host_scan_recipe_port_settings_scan_level"></a> [host\_scan\_recipe\_port\_settings\_scan\_level](#input\_host\_scan\_recipe\_port\_settings\_scan\_level) | Vulnerability scanning service port scan level | `string` | `"STANDARD"` | no |
| <a name="input_ingress_rules_map"></a> [ingress\_rules\_map](#input\_ingress\_rules\_map) | [Workload Security List] Ingress Rules Map | <pre>map(object({<br>    ingress_security_rules_tcp_options_destination_port_range_max = number<br>    ingress_security_rules_tcp_options_destination_port_range_min = number<br>    ingress_security_rules_tcp_options_source_port_range_max      = number<br>    ingress_security_rules_tcp_options_source_port_range_min      = number<br>  }))</pre> | `{}` | no |
| <a name="input_ip_sec_connection_static_routes"></a> [ip\_sec\_connection\_static\_routes](#input\_ip\_sec\_connection\_static\_routes) | IPSec connection static routes | `list(string)` | `[]` | no |
| <a name="input_is_flow_log_enabled"></a> [is\_flow\_log\_enabled](#input\_is\_flow\_log\_enabled) | Enable or Disable VCN Flow Logs | `bool` | `false` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | Encryption key OCID for security admin policy | `string` | `"PLACEHOLDER"` | no |
| <a name="input_lb_users_group_name"></a> [lb\_users\_group\_name](#input\_lb\_users\_group\_name) | The name for the load balancer users group name | `string` | `"LBUsers"` | no |
| <a name="input_network_admin_group_name"></a> [network\_admin\_group\_name](#input\_network\_admin\_group\_name) | The name for the network administrator group name | `string` | `"Virtual-Network-Admins"` | no |
| <a name="input_network_compartment_name"></a> [network\_compartment\_name](#input\_network\_compartment\_name) | Name of the top level network compartment | `string` | `"network"` | no |
| <a name="input_provider_service_key_name"></a> [provider\_service\_key\_name](#input\_provider\_service\_key\_name) | The provider service key that the provider gives you when you set up a virtual circuit connection from the provider to OCI | `string` | `""` | no |
| <a name="input_retention_rule_duration_time_amount"></a> [retention\_rule\_duration\_time\_amount](#input\_retention\_rule\_duration\_time\_amount) | Amount of retention rule duration time in days | `string` | `365` | no |
| <a name="input_security_admins_group_name"></a> [security\_admins\_group\_name](#input\_security\_admins\_group\_name) | The name of the security admin group | `string` | `"SecurityAdmins"` | no |
| <a name="input_security_compartment_name"></a> [security\_compartment\_name](#input\_security\_compartment\_name) | Name of the top level security compartment | `string` | `"security"` | no |
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
| <a name="input_workload_admins_group_name"></a> [workload\_admins\_group\_name](#input\_workload\_admins\_group\_name) | The name for the workload administrators group | `string` | `"Workload-Admins"` | no |
| <a name="input_workload_storage_admins_group_name"></a> [workload\_storage\_admins\_group\_name](#input\_workload\_storage\_admins\_group\_name) | The name for the workload storage administrators group | `string` | `"Workload-Storage-Admins"` | no |
| <a name="input_workload_storage_users_group_name"></a> [workload\_storage\_users\_group\_name](#input\_workload\_storage\_users\_group\_name) | The name for the workload storage users group | `string` | `"Workload-Storage-Users"` | no |
| <a name="input_workload_users_group_name"></a> [workload\_users\_group\_name](#input\_workload\_users\_group\_name) | The name for the workload users group | `string` | `"Workload-Users"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnet_id"></a> [database\_subnet\_id](#output\_database\_subnet\_id) | Database subnet ocid |
| <a name="output_fss_subnet_id"></a> [fss\_subnet\_id](#output\_fss\_subnet\_id) | Shared service subnet ocid |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | Private subnet ocid |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | Public subnet ocid |
| <a name="output_vcn_ocid"></a> [vcn\_ocid](#output\_vcn\_ocid) | VCN ocid |
| <a name="output_workload_compartment_ocids"></a> [workload\_compartment\_ocids](#output\_workload\_compartment\_ocids) | Workload compartments to deploy applications to |
