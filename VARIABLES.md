## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_applications-compartment"></a> [applications-compartment](#module\_applications-compartment) | ./compartments/applications-compartment | n/a |
| <a name="module_audit"></a> [audit](#module\_audit) | ./security/audit | n/a |
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./security/bastion | n/a |
| <a name="module_budget"></a> [budget](#module\_budget) | ./budget | n/a |
| <a name="module_cloud-guard"></a> [cloud-guard](#module\_cloud-guard) | ./security/cloud-guard | n/a |
| <a name="module_common-infra-compartment"></a> [common-infra-compartment](#module\_common-infra-compartment) | ./compartments/common-infra-compartment | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./iam | n/a |
| <a name="module_network-compartment"></a> [network-compartment](#module\_network-compartment) | ./compartments/network-compartment | n/a |
| <a name="module_parent-compartment"></a> [parent-compartment](#module\_parent-compartment) | ./compartments/parent-compartment | n/a |
| <a name="module_security-compartment"></a> [security-compartment](#module\_security-compartment) | ./compartments/security-compartment | n/a |
| <a name="module_vcn"></a> [vcn](#module\_vcn) | ./vcn | n/a |
| <a name="module_workload-compartment"></a> [workload-compartment](#module\_workload-compartment) | ./compartments/workload-compartment | n/a |

## Resources

| Name | Type |
|------|------|
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_fingerprint"></a> [api\_fingerprint](#input\_api\_fingerprint) | The fingerprint of API | `string` | n/a | yes |
| <a name="input_api_private_key_path"></a> [api\_private\_key\_path](#input\_api\_private\_key\_path) | The local path to the API private key | `string` | n/a | yes |
| <a name="input_bastion_client_cidr_block_allow_list"></a> [bastion\_client\_cidr\_block\_allow\_list](#input\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that bastion is allowed to connect | `list(string)` | n/a | yes |
| <a name="input_bastion_subnet_cidr_block"></a> [bastion\_subnet\_cidr\_block](#input\_bastion\_subnet\_cidr\_block) | CIDR Block for bastion subnet | `string` | n/a | yes |
| <a name="input_budget_alert_rule_recipients"></a> [budget\_alert\_rule\_recipients](#input\_budget\_alert\_rule\_recipients) | (Required if using budget alerts): Target email address for budget alerts | `string` | n/a | yes |
| <a name="input_budget_alert_rule_threshold"></a> [budget\_alert\_rule\_threshold](#input\_budget\_alert\_rule\_threshold) | (Required if using budget alerts): The target spending threshold for the budget | `string` | n/a | yes |
| <a name="input_budget_alerting"></a> [budget\_alerting](#input\_budget\_alerting) | Set to true to enable budget alerting | `bool` | n/a | yes |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | (Required if using budget alerts): The amount of the budget expressed as a number in the currency of the customer's rate card. | `string` | n/a | yes |
| <a name="input_cloud_guard_configuration_status"></a> [cloud\_guard\_configuration\_status](#input\_cloud\_guard\_configuration\_status) | the status of the Cloud Guard tenant (ENABLED or DISABLED) | `string` | n/a | yes |
| <a name="input_current_user_ocid"></a> [current\_user\_ocid](#input\_current\_user\_ocid) | OCID of the current user | `string` | n/a | yes |
| <a name="input_database_subnet_cidr_blocks"></a> [database\_subnet\_cidr\_blocks](#input\_database\_subnet\_cidr\_blocks) | List of Database Subnet CIDR Block (one per workload) | `list(string)` | n/a | yes |
| <a name="input_database_subnet_dns_labels"></a> [database\_subnet\_dns\_labels](#input\_database\_subnet\_dns\_labels) | List of Database Subnet DNS Label (one per workload) | `list(string)` | n/a | yes |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | Encryption key OCID for security admin policy | `string` | n/a | yes |
| <a name="input_parent_compartment_name"></a> [parent\_compartment\_name](#input\_parent\_compartment\_name) | Name of the top level / parent compartment | `string` | n/a | yes |
| <a name="input_private_subnet_cidr_blocks"></a> [private\_subnet\_cidr\_blocks](#input\_private\_subnet\_cidr\_blocks) | List of Private Subnet CIDR Block (one per workload) | `list(string)` | n/a | yes |
| <a name="input_private_subnet_dns_labels"></a> [private\_subnet\_dns\_labels](#input\_private\_subnet\_dns\_labels) | List of Private Subnet DNS Label (one per workload) | `list(string)` | n/a | yes |
| <a name="input_public_subnet_cidr_block"></a> [public\_subnet\_cidr\_block](#input\_public\_subnet\_cidr\_block) | Public Subnet CIDR Block | `string` | n/a | yes |
| <a name="input_public_subnet_dns_label"></a> [public\_subnet\_dns\_label](#input\_public\_subnet\_dns\_label) | Public Subnet DNS Label | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | the OCI region | `string` | n/a | yes |
| <a name="input_retention_rule_duration_time_amount"></a> [retention\_rule\_duration\_time\_amount](#input\_retention\_rule\_duration\_time\_amount) | Amount of retention rule duration time in days | `string` | n/a | yes |
| <a name="input_shared_service_subnet_cidr_block"></a> [shared\_service\_subnet\_cidr\_block](#input\_shared\_service\_subnet\_cidr\_block) | Shared Service Subnet CIDR Block | `string` | n/a | yes |
| <a name="input_shared_service_subnet_dns_label"></a> [shared\_service\_subnet\_dns\_label](#input\_shared\_service\_subnet\_dns\_label) | Shared Service Subnet DNS Label | `string` | n/a | yes |
| <a name="input_tag_cost_center"></a> [tag\_cost\_center](#input\_tag\_cost\_center) | CostCenter tag value | `string` | n/a | yes |
| <a name="input_tag_geo_location"></a> [tag\_geo\_location](#input\_tag\_geo\_location) | GeoLocation tag value | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_vault_id"></a> [vault\_id](#input\_vault\_id) | Vault OCID for security admin policy | `string` | n/a | yes |
| <a name="input_vcn_dns_label"></a> [vcn\_dns\_label](#input\_vcn\_dns\_label) | VCN DNS Label | `string` | n/a | yes |
| <a name="input_workload_compartment_names"></a> [workload\_compartment\_names](#input\_workload\_compartment\_names) | List of application workload compartment names | `list(string)` | n/a | yes |
| <a name="input_activity_detector_recipe_display_name"></a> [activity\_detector\_recipe\_display\_name](#input\_activity\_detector\_recipe\_display\_name) | display name for activity detector recipe | `string` | `"OCI Activity Detector Recipe"` | no |
| <a name="input_agent_cis_benchmark_settings_scan_level"></a> [agent\_cis\_benchmark\_settings\_scan\_level](#input\_agent\_cis\_benchmark\_settings\_scan\_level) | Agent bechamrking settings scan level | `string` | `"STRICT"` | no |
| <a name="input_applications_compartment_name"></a> [applications\_compartment\_name](#input\_applications\_compartment\_name) | Name of the top level / parent compartment | `string` | `"applications"` | no |
| <a name="input_bastion_max_session_ttl_in_seconds"></a> [bastion\_max\_session\_ttl\_in\_seconds](#input\_bastion\_max\_session\_ttl\_in\_seconds) | The maximum amount of time that bastion session can remain active | `number` | `1800` | no |
| <a name="input_bastion_type"></a> [bastion\_type](#input\_bastion\_type) | the type of bastion service | `string` | `"STANDARD"` | no |
| <a name="input_break_glass_username_list"></a> [break\_glass\_username\_list](#input\_break\_glass\_username\_list) | Break Glass Admin users list | `list(string)` | `[]` | no |
| <a name="input_budget_alert_rule_message"></a> [budget\_alert\_rule\_message](#input\_budget\_alert\_rule\_message) | (Optional if using budget alerts): The alert message for budget alerts. | `string` | `"Default budget alert"` | no |
| <a name="input_common_infra_compartment_name"></a> [common\_infra\_compartment\_name](#input\_common\_infra\_compartment\_name) | Name of the top level / parent compartment | `string` | `"common-infra"` | no |
| <a name="input_configuration_detector_recipe_display_name"></a> [configuration\_detector\_recipe\_display\_name](#input\_configuration\_detector\_recipe\_display\_name) | display name for configuration detector recipe | `string` | `"OCI Configuration Detector Recipe"` | no |
| <a name="input_egress_rules_map"></a> [egress\_rules\_map](#input\_egress\_rules\_map) | [Workload Security List] Egress Rules Map | <pre>map(object({<br>    egress_security_rules_tcp_options_destination_port_range_max = number<br>    egress_security_rules_tcp_options_destination_port_range_min = number<br>    egress_security_rules_tcp_options_source_port_range_max      = number<br>    egress_security_rules_tcp_options_source_port_range_min      = number<br>  }))</pre> | `{}` | no |
| <a name="input_host_scan_recipe_agent_settings_agent_configuration_vendor"></a> [host\_scan\_recipe\_agent\_settings\_agent\_configuration\_vendor](#input\_host\_scan\_recipe\_agent\_settings\_agent\_configuration\_vendor) | Vulnerability scanning service agent vendor | `string` | `"OCI"` | no |
| <a name="input_host_scan_recipe_agent_settings_scan_level"></a> [host\_scan\_recipe\_agent\_settings\_scan\_level](#input\_host\_scan\_recipe\_agent\_settings\_scan\_level) | Vulnerability scanning service agent scan level | `string` | `"STANDARD"` | no |
| <a name="input_host_scan_recipe_display_name"></a> [host\_scan\_recipe\_display\_name](#input\_host\_scan\_recipe\_display\_name) | Vulnerability scanning service display name | `string` | `"OCI-LZ-Scanning-Service-Recipe"` | no |
| <a name="input_host_scan_recipe_port_settings_scan_level"></a> [host\_scan\_recipe\_port\_settings\_scan\_level](#input\_host\_scan\_recipe\_port\_settings\_scan\_level) | Vulnerability scanning service port scan level | `string` | `"STANDARD"` | no |
| <a name="input_host_scan_target_description"></a> [host\_scan\_target\_description](#input\_host\_scan\_target\_description) | Vulnerability scanning service target description | `string` | `"Vulnerability scanning service scan target"` | no |
| <a name="input_host_scan_target_display_name"></a> [host\_scan\_target\_display\_name](#input\_host\_scan\_target\_display\_name) | Vulnerability scanning service target display name | `string` | `"OCI-LZ-Scanning-Service-Target"` | no |
| <a name="input_ingress_rules_map"></a> [ingress\_rules\_map](#input\_ingress\_rules\_map) | [Workload Security List] Ingress Rules Map | <pre>map(object({<br>    ingress_security_rules_tcp_options_destination_port_range_max = number<br>    ingress_security_rules_tcp_options_destination_port_range_min = number<br>    ingress_security_rules_tcp_options_source_port_range_max      = number<br>    ingress_security_rules_tcp_options_source_port_range_min      = number<br>  }))</pre> | `{}` | no |
| <a name="input_network_compartment_name"></a> [network\_compartment\_name](#input\_network\_compartment\_name) | Name of the top level / parent compartment | `string` | `"network"` | no |
| <a name="input_security_compartment_name"></a> [security\_compartment\_name](#input\_security\_compartment\_name) | Name of the top level / parent compartment | `string` | `"security"` | no |
| <a name="input_vcn_cidr_block"></a> [vcn\_cidr\_block](#input\_vcn\_cidr\_block) | Primary VCN CIDR Block | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vss_scan_schedule"></a> [vss\_scan\_schedule](#input\_vss\_scan\_schedule) | Vulnerability scanning service scan schedule | `string` | `"DAILY"` | no |
| <a name="input_vulnerability_scanning_service_policy_name"></a> [vulnerability\_scanning\_service\_policy\_name](#input\_vulnerability\_scanning\_service\_policy\_name) | Name of Scanning Service Policy | `string` | `"OCI-LZ-Scanning-Service-Policy"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnet_id"></a> [database\_subnet\_id](#output\_database\_subnet\_id) | Database subnet ocid |
| <a name="output_fss_subnet_id"></a> [fss\_subnet\_id](#output\_fss\_subnet\_id) | Shared service subnet ocid |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | Private subnet ocid |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | Public subnet ocid |
| <a name="output_vcn_ocid"></a> [vcn\_ocid](#output\_vcn\_ocid) | VCN ocid |
| <a name="output_workload_compartment_ocids"></a> [workload\_compartment\_ocids](#output\_workload\_compartment\_ocids) | Workload compartments to deploy applications to |
