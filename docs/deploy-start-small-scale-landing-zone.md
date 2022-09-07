# Deploying the Start Small and Scale Landing Zone {#deploy-start-small-scale-landing-zone .concept}

Use the start small and scale landing zone to deploy a secure cloud environment that's ready for you to launch a workload in Oracle Cloud Infrastructure.

**Important:** This reference architecture provides a basic template for deployment that lets you specify preconfigured security settings for Audit logs and protocols for the Bastion service. See [How Do I Decide Which Landing Zone to Use?](technology-implementation.md#how-do-i-choose)

## Prerequisites {#prerequisites .vl-include-in-page-toc}

Before you launch the start small and scale landing zone, prepare the following information.

-   Tag values for the **CostCenter** and **GeoLocation** tags. Every resource that is created by the landing zone stack will be tagged with the values that you provide.
-   A name for the parent compartment. The parent compartment is the top-level organizational compartment that is created by the landing zone.
-   Names for one or more workload compartments under the parent compartment.
-   Email addresses for one or more break-glass users. Break-glass users have emergency access to all Oracle Cloud Infrastructure resources.
-   CIDR block for the allowlist on the bastion.
-   CIDR blocks for the following subnets created within the virtual cloud network (VCN):

    -   Shared
    -   Bastion

## How to Deploy {#how-to-deploy .vl-include-in-page-toc}

Install the start small and scale landing zone from the **Deploy a baseline landing zone** Quickstarts card on the Console home page.

The deployment process takes you through selecting a compartment for your tenancy and setting up security configurations for enabling logging and protocols for the Bastion service. Provide the following information:

-   **Compartment:** The compartment provides the compartment structure for the start small and scale landing zone. When you select a compartment, this provides the parent compartment for security, networking, and workloads.
-   **Advanced Logging:** Lets you enable [audit logs](deploy-start-small-scale-landing-zone.md#how-to-deploy__audit-logs) and [VCN flow logs](deploy-start-small-scale-landing-zone.md#how-to-deploy__vcn-flow-logs). The following options are available:

    -   **AUDIT_LOGS:** Enables audit logs only.
    -   **FLOW_LOGS:** Enables VCN flow logs only.
    -   **BOTH:** Enables audit logs and VCN flow logs.
    -   **NONE:** Do not enable advanced logging.

    **Note:** After you enable logging, you cannot disable it.
-   **Bastion Client CIDR Block Allow List:** Select at least one CIDR block that will be allowed to connect to the Oracle Cloud Infrastructure Bastion service. A bastion is a secure method of connecting to the resources within the cloud environment.

After you start the deployment, it takes about 7 to 9 minutes to provision fully. To view deployment progress, click **Manage deployments**.

When the landing zone is created, each template for deployment is listed as a stack in Resource Manager. (Resource Manager is the service that builds the landing zone.) You can select each stack to view more details in the logs. For more information, see [Managing Stacks and Jobs](https://docs.oracle.com/iaas/Content/ResourceManager/Tasks/managingstacksandjobs.htm).

### Audit Logs {#audit-logs .section .vl-include-in-page-toc}

When you enable audit logs, the Oracle Cloud Infrastructure Audit service automatically records calls to all supported Oracle Cloud Infrastructure public API endpoints and logs them to the audit log. This includes all API calls made by the Console, command line interface (CLI), software development kits (SDKs), and other Oracle Cloud Infrastructure services.

After the audit log is created, you can manually enable write access logs to meet the [Center for Internet Security (CIS) Oracle Cloud Infrastructure Benchmark](https://www.cisecurity.org/benchmark/oracle_cloud).

### VCN Flow Logs {#vcn-flow-logs .section .vl-include-in-page-toc}

When you enable VCN flow logs, details are provided about traffic that passes through your virtual cloud network (VCN). This information helps you audit traffic and troubleshoot your security risks.

## Managing Your Landing Zone {#managing-landing-zone .vl-include-in-page-toc}

The start small and scale landing zone deploys resources into the root compartment of your tenancy. You can view and manage these resources in the relevant areas of the Console, such as Identity, Networking, and Governance.

## Destroying the Stack {#deleting .vl-include-in-page-toc}

If you no longer need the start small and scale landing zone stack, destroy it by deleting it from the **Stacks** list in Resource Manager. For steps, see [Managing Stacks and Jobs](https://docs.oracle.com/iaas/Content/ResourceManager/Tasks/managingstacksandjobs.htm).

## Next Steps {#next-steps .vl-include-in-page-toc}

After completing a start small and scale landing zone deployment, we recommend you review the [CAF landing zone architectural guidance](landing-zone.md) and deploy the [enterprise scale baseline landing zone](deploy-landing-zone.md). The enterprise scale baseline landing zone lets you deploy more workloads and use additional Oracle Cloud Infrastructure functionality.