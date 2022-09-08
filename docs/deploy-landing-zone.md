# Deploying the Enterprise Scale Baseline Landing Zone {#baseline-landing-zone .concept}

Use the enterprise scale baseline landing zone to deploy a secure cloud environment that's ready for you to launch new projects and workloads in Oracle Cloud Infrastructure.

**Important:** This reference architecture provides an enterprise-scale architecture and deployment that includes designs for governance, security segmentation, and separation of duties. See [How Do I Decide Which Landing Zone to Use?](technology-implementation.md#how-do-i-choose)

## Prerequisites {#prerequisites .vl-include-in-page-toc}

Before you launch the enterprise scale baseline landing zone, prepare the following information.

-   Tag values for the **CostCenter** and **GeoLocation** tags. Every resource that is created by the landing zone stack will be tagged with the values that you provide.
-   A name for the parent compartment. The parent compartment is the top-level organizational compartment that is created by the landing zone.
-   Email addresses for one or more break-glass users. Break-glass users have emergency access to all Oracle Cloud Infrastructure resources.
-   CIDR block for the allowlist on the bastion.
-   CIDR blocks for the following subnets created within the virtual cloud network (VCN):

    -   Shared
    -   Bastion

## How to Deploy {#how-to-deploy .vl-include-in-page-toc}

Install the enterprise scale baseline landing zone using the Console, Resource Manager, or the Oracle Cloud Infrastructure Terraform provider.

The Terraform template is available on GitHub: [https://github.com/oracle-quickstart/oci-enterprise-scale-baseline-landing-zone](https://github.com/oracle-quickstart/oci-enterprise-scale-baseline-landing-zone)

### Terraform Modules {#terraform-modules .section .vl-include-in-page-toc}

The enterprise scale baseline landing zone is composed of multiple Terraform modules. Each module is written to work together in a stack.

The following table lists the modules in the enterprise scale baseline landing zone.

<table>
  <thead>
    <tr>
      <th scope="col">Module</th>
      <th scope="col">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Compartments</th>
      <td>Contains submodules for creating the compartment structure for the enterprise scale baseline landing zone. These compartments include the parent compartment and compartments for security, and networking.</td>
    </tr>
    <tr>
      <th scope="row">Budget</th>
      <td>Builds a compartment-level budget alarm based on a threshold that you define. The budget is valid for everything that resides under the parent compartment. This module is optional.</td>
    </tr>
    <tr>
      <th scope="row">Virtual cloud network (VCN)</th>
      <td>Builds and configures all network-related resources, including a VCN, subnets, gateways, security lists, and routing rules. This module also configures optional dynamic routing gateways (DRGs), using either Site-to-Site VPN or FastConnect.</td>
    </tr>
    <tr>
      <th scope="row">Identity and access management (IAM)</th>
      <td>
        <p>Creates nearly all required policies and groups. A submodule creates accounts for emergency access, called break-glass users.</p>
        <p>In some cases, if permissions are related to a specific feature, an IAM policy might be created in a different module. For example, if Cloud Guard is used, the related IAM policies are created in the Cloud Guard submodule.</p>
      </td>
    </tr>
    <tr>
      <th scope="row">Security</th>
      <td>Implements VCN flow logs, Cloud Guard, Audit logs, and the Bastion service.</td>
    </tr>
  </tbody>
</table>

Knowing the contents of each module can help you understand how to scale and operate the stack. In the top-level directory, each module has a `module-variables.tf` file that defines the module's variables, a `module.tf` file that creates the module's resources, and a subdirectory that is named after the module and contains the submodules. For example, the compartments module includes a `compartments-variables.tf` file, a `compartments.tf` file, and a subdirectory named `compartments`.

### Tags {#tags .section .vl-include-in-page-toc}

The enterprise scale baseline landing zone includes a set of free-form tags that are applied to resources created within the template. Each resource is given a default assigned value for the **Description** tag. The values that you define when you create the enterprise scale baseline landing zone stack propagate to the **CostCenter** and **GeoLocation** tags.

### IAM Policies and Groups {#iam-policies-groups .section .vl-include-in-page-toc}

Oracle Cloud Infrastructure Identity and Access Management (IAM) lets you control who has access to specific cloud resources and what type of access a group of users has.

The enterprise scale baseline landing zone provisions IAM groups with established roles and access levels. Each IAM group is referenced in IAM policies that grant access to the associated resources. All groups belong to the parent compartment. Each policy belongs to the compartment that is closest to the resource that it controls access to.

The enterprise scale baseline landing zone stack provisions the groups and IAM policies listed in the following table. To override the default group names, update the Terraform variables when you create the stack. For example, you can rename groups to fit your organizational structure or to map with a federated identity service.

<table>
  <thead>
    <tr>
      <th scope="col">Group</th>
      <th scope="col">Policy Name</th>
      <th scope="col">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Virtual-Network-Admins</td>
      <td>OCI-LZ-VCNAdminPolicy</td>
      <td>Network administrators are allowed to manage all network resources in the network compartment.</td>
    </tr>
    <tr>
      <td>Security-Admins</td>
      <td>OCI-LZ-SecurityAdmins</td>
      <td>Security administrators are allowed to manage and use encryption keys to encrypt resources. They can view resources in the Vault service, which manages user keys and secrets. Security administrators can also manage Bastion resources, which allow users to connect to hosts and subnets in the VCN. Access for security administrators is scoped to the security compartment.</td>
    </tr>
    <tr>
      <td>Platform-Admins</td>
      <td>OCI-LZ-Platform-Admins</td>
      <td>Platform administrators manage all cost, billing, and budget related resources.</td>
    </tr> 
    <tr>
      <td>IAM-Admins</td>
      <td>OCI-LZ-IAM-Admins</td>
      <td>IAM administrators are allowed to manage groups, dymanic groups, and policies. IAM Administrators should also be able to manage users and groups permissions via IDP. They can users and manage their credentials including API keys and auth tokens.</td>
    </tr>
    <tr>
      <td>Ops-Admins</td>
      <td>OCI-LZ-Ops-Admins</td>
      <td>Ops administrators are allowed to manage alarms, metrics and topics.</td>
    </tr>
  </tbody>
</table>

The following diagram shows the IAM groups and policies that are created by the enterprise scale baseline landing zone.

<img src="images/caf-lz-iam.svg" alt="Diagram of the IAM groups and policies that are created by the enterprise scale baseline landing zone." outputclass="diagram">

Optionally, you can [add additional users](https://docs.oracle.com/iaas/Content/Identity/Tasks/managingusers.htm) to the groups that are created.

To add users to groups:

1.  Open the navigation menu and click **Identity & Security**. Under **Identity**, click **Users**. A list of the users in your tenancy is displayed.
2.  Locate the user in the list.
3.  Click the user. The user's details are displayed.
4.  Click **Groups**.
5.  Click **Add User to Group**.
6.  Select the group from the drop-down list, and then click **Add**.

You can also manage user membership in groups through the API, SDKs, CLI, or Terraform.

## Cloud Guard {#cloud-guard .vl-include-in-page-toc}

Use Cloud Guard to monitor and manage the security of your cloud resources.

### Usage and Best Practices {#cloud-guard-usage .section .vl-include-in-page-toc}

[Cloud Guard](https://docs.cloud.oracle.com/iaas/cloud-guard/home.htm) is a cloud-native service that helps customers monitor, identify, achieve, and maintain a strong security posture on Oracle Cloud. Use the service to examine your Oracle Cloud Infrastructure resources for security weakness related to configuration, and your Oracle Cloud Infrastructure operators and users for risky activities. Upon detection, Cloud Guard can suggest, assist, or take corrective actions, based on your configuration.

To use Cloud Guard, you define target resources that you want Cloud Guard to monitor. Then, you use either Oracle-managed or user-managed detector recipes, or sets of rules, to examine the resources and activities in the target and identify problems.

The reporting region for Cloud Guard is set to your tenancy's home region by default. This is because if Cloud Guard is already enabled in your tenancy and the reporting region is not the home region, Cloud Guard would need to be disabled and then reenabled, which adds unnecessary complexity. Cloud Guard can detect events in the region where the enterprise scale baseline landing zone is deployed, even if the reporting region is different. If necessary, you can manually change the reporting region. For more information, see [Getting Started with Cloud Guard](https://docs.oracle.com/iaas/cloud-guard/using/part-start.htm).

When you provision Cloud Guard resources using the enterprise scale baseline landing zone stack, the target is all resources within the parent compartment. The enterprise scale baseline landing zone includes two Oracle-managed recipes, OCI Configuration Detector Recipe and OCI Activity Detector Recipe. These detector recipes perform checks and identify potential security problems on your resources.

Optionally, you can create your own responder recipes and rules. Responders are structured in a similar way to detectors. A responder is an action that Cloud Guard can take when a detector has identified a problem. Each responder uses a responder recipe with rules that define the action or set of actions to take in response to a problem that a detector has identified. The available actions are resource-specific.

### Enabling or Disabling Cloud Guard {#enable-cloud-guard .section .vl-include-in-page-toc}

To enable Cloud Guard at the tenancy level, in the enterprise scale baseline landing zone stack, set the variable `cloud_guard_configuration_status` to `ENABLE`. To disable the service, set the variable to `DISABLE`.

### Cloning Cloud Guard Recipes {#clone-cloud-guard-recipes .section .vl-include-in-page-toc}

You can [clone detector recipes](https://docs.cloud.oracle.com/iaas/cloud-guard/using/detect-recipes.htm#detect-recipes-clone) to fine-tune the set of detector recipes available to use in your environment. Only a member of the CloudGuardArchitect group can clone recipes.

### Cloud Guard IAM Policies {#cloud-guard-permissions .section .vl-include-in-page-toc}

The IAM policies in the following table are provisioned with Cloud Guard. You might need to add users to specific IAM groups to allow them to access and manage Cloud Guard resources.

<table>
  <thead>
    <tr>
      <th scope="col">Policy Name</th>
      <th scope="col">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>OCI-LZ-Cloud-Guard-Policy</td>
      <td>
        <p>Configures permissions for Cloud Guard to access tenancy resources:</p>
        <ul>
          <li>Read-only access to tenancy keys</li>
          <li>Read-only access to compartments</li>
          <li>Read-only access to compute management family</li>
          <li>Read-only access to virtual network family</li>
          <li>Read-only access to volume family</li>
          <li>Read-only access to audit events</li>
          <li>Read-only access to vaults</li>
          <li>Read-only access to object family</li>
          <li>Read-only access to load balancers</li>
          <li>Read-only access to groups</li>
          <li>Read-only access to dynamic groups</li>
          <li>Read-only access to users</li>
          <li>Read-only access to database family</li>
          <li>Read-only access to authentication policies</li>
          <li>Read-only access to policies</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>OCI-LZ-Scanning-Service-Policy</td>
      <td>
        <p>Configures permissions for the Vulnerability Scanning service to access resources in the parent compartment:</p>
        <ul>
          <li>Manage access to instances</li>
          <li>Read-only access to compartments</li>
          <li>Read-only access to VNICs</li>
          <li>Read-only access to VNIC attachments</li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

### Cloud Guard Target {#cloud-guard-target .section .vl-include-in-page-toc}

**Target name:** OCI-LZ-Cloud-Guard-Target

In the enterprise scale baseline landing zone stack, a user-managed Cloud Guard target is deployed. The target resource ID is the parent compartment and all resources within it. The target uses two Oracle-managed detector recipes.

### Vulnerability Scanning Host Scan Recipe {#vulnerability-scanning-host-scan-recipe .section .vl-include-in-page-toc}

**Host scan recipe name:** OCI-LZ-Scanning-Service-Recipe

In the enterprise scale baseline landing zone stack, a user-managed host scan recipe for [Vulnerability Scanning](https://docs.oracle.com/iaas/scanning/using/overview.htm) is deployed into the security compartment. The agent, the port scanning level, and the scan schedule are configured in Terraform.

### Vulnerability Scanning Host Scan Target {#vulnerability-scanning-host-scan-target .section .vl-include-in-page-toc}

**Host scan target name:** OCI-LZ-Scanning-Service-Target

In the enterprise scale baseline landing zone stack, a user-managed host scan target for Vulnerability Scanning is deployed into the security compartment. This resource uses the Vulnerability Scanning host scan recipe that is created by the stack. The target resource ID is the parent compartment and all resources within it.

## Emergency Break Glass Users {#emergency-access-accounts .vl-include-in-page-toc}

Users in the break-glass user group are administrators who have emergency access to all Oracle Cloud Infrastructure services and resources in the tenancy. The users in this group must enable multi-factor authentication.

### Resources {#break-glass-resources .section .vl-include-in-page-toc}

The landing zone stack provisions the following IAM resources for break-glass users:

-   **Default username:** break_glass_user_<var>&lt;number&gt;</var>
-   **Default group name:** Administrators
-   **Default policy:** OCI-LZ-Admin-TenantAdminPolicy

The break-glass IAM policy contains the following statement:

<pre class="copy"><code>
Allow group <var>&lt;administrator_group_name&gt;</var> to manage all-resources in tenancy where request.user.mfaTotpVerified='true'.
</code></pre>

### Usage {#break-glass-usage .section .vl-include-in-page-toc}

The enterprise scale baseline landing zone stack provisions users in the break-glass group using the `break_glass_user_email_list` variable. To create multiple break-glass users, provide multiple valid email addresses for this list variable.

After break-glass users are provisioned, the system sends a password reset email to each user to grant access to their account. When a break-glass user [signs in to the Console](https://docs.oracle.com/iaas/Content/GSG/Tasks/signingin.htm), they can view their membership in groups by reviewing their user settings.

Each break-glass user must [enable multi-factor authentication (MFA)](https://docs.oracle.com/iaas/Content/Identity/Tasks/usingmfa.htm).

To enable MFA for your user account:

**Prerequisite:** You must install a [supported authenticator app](https://docs.oracle.com/iaas/Content/Identity/Tasks/usingmfa.htm) on the mobile device you intend to register for MFA.

1.  In the upper-right corner of the Console, open the **Profile** menu and then select **User Settings**. Your user details are displayed.
1.  Click **Enable Multi-Factor Authentication**.
1.  Scan the QR code displayed in the dialog with your mobile device's authenticator app.

    **Note:** If you close the browser, or if the browser crashes before you can enter the verification code, you must generate a new QR code and scan it again with your app. To generate a new QR code, click the **Enable Multi-Factor Authentication** button again.

1.  In the **Verification Code** field, enter the code displayed on your authenticator app.
1.  Click **Enable**.

Your mobile device is now registered with the IAM service and your account is enabled for MFA. Every time you sign in, you are prompted for your username and password first. After you provide the correct credentials, you will be prompted for a TOTP code generated by the authenticator app on your registered mobile device. *You must have your registered mobile device available every time you sign in to Oracle Cloud Infrastructure.*

After MFA is enabled for a break-glass account, the account can be used to manage the tenancy through the API, SDKs, CLI, or Console.

## Bastion {#baseline-landing-zone-bastion .vl-include-in-page-toc}

The Bastion service provides restricted and time-limited access to cloud resources without public-facing endpoints.

There are two types of bastion sessions, managed SSH and port forwarding. The type of bastion session depends on the target resource.

-   Managed SSH sessions simplify SSH access to native Oracle Linux images running the Oracle Cloud Agent software.
-   Port forwarding creates a secure connection between a specific port on the client machine and a specific port on the target resource.

### Resources {#bastion-resources .section .vl-include-in-page-toc}

The enterprise scale baseline landing zone stack creates a bastion named LZBastion and a subnet named OCI-LZ-Bastion-<var>&lt;region_key&gt;</var>-subnet. The subnet and bastion are attached to the default VCN residing in the network compartment.

The stack does not provision bastion sessions. You can create bastion sessions after the bastion has been provisioned.

### Usage {#bastion-usage .section .vl-include-in-page-toc}

To deploy or update the bastion module using Resource Manager, provide the required values listed in the following table.

|Field|Variable Name|Description|
|-----|-------------|-----------|
|Bastion Subnet CIDR Block|`bastion_subnet_cidr_block`|CIDR block for the bastion subnet.|
|Bastion Client CIDR Block Allowlist|`bastion_client_cidr_block_allow_list`|A list of address ranges in CIDR notation that the bastion is allowed to connect to.|

After the bastion has been provisioned, you can [create bastion sessions](https://docs.oracle.com/iaas/Content/Bastion/Tasks/managingbastions.htm) using the API, SDKs, CLI, or Console.

For more information about bastions, see [Bastion](https://docs.oracle.com/iaas/Content/Bastion/home.htm).

## Monitoring {#monitoring .vl-include-in-page-toc} 

The enterprise scale baseline landing zone includes modules for notification topics, alarms, and subscriptions. By default this includes notifications for security, budget, and networking resources.

The notification recipient can be configured using the corresponding input variables for email endpoints.

|Field|Variable Name|Description|
|-----|-------------|-----------|
|Security Admin Emails|`security_admin_email_endpoints`|Notifications for creating, updating, and deleting security resources.|
|Budget Admin Emails|`budget_admin_email_endpoints`|Notifications for creating, updating, and deleting budget resources.|
|Network Admin Emails|`network_admin_email_endpoints`|Notifications for creating, updating, and deleting network resources.|

The budget that is created applies to the parent compartment.

For more information about budgets, see [Budgets Overview](https://docs.oracle.com/iaas/Content/Billing/Concepts/budgetsoverview.htm).

## Budgets {#budgets .vl-include-in-page-toc}

The enterprise scale baseline landing zone includes an optional budget module.

To enable the budgets feature when deploying or updating the stack using Resource Manager, select the option for **Budget Alerting**, and then provide the required values listed in the following table.

|Field|Variable Name|Description|
|-----|-------------|-----------|
|Budget Amount|`budget_amount`|Monthly budget.|
|Budget Alert Rule Threshold|`budget_alert_rule_threshold`|Alerting threshold for spend.|
|Budget Alert Rule Recipient|`budget_alert_rule_recipients`|Email address to receive budget alerts.|

## Global Resources Control {#global-resource-control .vl-include-in-page-toc} 

The Enterprise Scale Baseline Landing Zone includes a global resources control through a variable flag deploy_global_resources. The default is set to true to deploy all resources. **If need to extend the Landing Zone to another region, please set it to false to avoid resource conflict at the tenancy level.**

### Global resources include:
* Cloud Guard service and related policies
* Audit Logging and related policies
* VCN Flow Log and related policies
* Groups and corresponding policies
