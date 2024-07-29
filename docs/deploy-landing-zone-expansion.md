# Deploying the Enterprise Scale Landing Zone Workload Expansion 

Use the workload expansion landing zone to deploy minimal IAM and Networking resources needed to deploy a workload in Oracle Cloud Infrastructure.

**Important:** This reference architecture provides a basic template for a workload that integrates with the enterprise-scale  landing zone. See [How Do I Decide Which Landing Zone to Use?](technology-implementation.md#how-do-i-choose)

## Prerequisites {#prerequisites .vl-include-in-page-toc}

Before you launch the workload expansion, prepare the following information.

-   Tag values for the **CostCenter** and **GeoLocation** tags. Every resource that is created by the landing zone stack will be tagged with the values that you provide.
-   The name of the new workload compartment as well as the parent application compartment ocid to attach the new compartment to.
-   The name and ocid of the networking compartment in which the VCN resides.
-   The VCN and NAT Gateways ocids to be used to create the workload subnets.
-   CIDR blocks for the following subnets created within the virtual cloud network (VCN):

    -   Private
    -   Database

## How to Deploy {#how-to-deploy .vl-include-in-page-toc}
Install the enterprise scale baseline landing zone first using the Console, Resource Manager, or the Oracle Cloud Infrastructure Terraform provider. The Workload Expansion can be deployed after as it builds on top of the Enterprise Scale Landing Zone and is not intended to be deployed as a standalone.

The Terraform template is available on GitHub: [https://github.com/oci-landing-zones/oci-esblz-workload-expansion](https://github.com/oci-landing-zones/oci-esblz-workload-expansion)

If deploying locally, create a terraform.tfvars file and populate with the required variables or override existing variables. 

For the following input variables, find the values in the outputs of the Baseline stack. This will allow you to use the networking and IAM resouces from the base.
   * network_compartment_id
   * applications_compartment_id
   * network_compartment_name
   * nat_gateway_id
   * vcn_id

Run **terraform apply** to provision the Workload Expansion or create a Resource Manager job to run the apply command. 


## IAM Policies and Groups {#iam-policies-groups .section .vl-include-in-page-toc}

The Workload Expansion adds the following IAM groups and policies to manage your workload.

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
      <td>Workload-Admins</td>
      <td>OCI-LZ-<var>&lt;WorkloadName&gt;</var>-WorkloadAdminPolicy</td>
      <td>Compute or workload administrators are allowed to manage all compute resources that host workloads. This includes the ability to manage all things related to creating instances, instance pools, autoscaling configurations, cluster networks, custom images, and images in the Partner Image catalog.</td>
    </tr>
    <tr>
      <td>Workload-Users</td>
      <td>OCI-LZ-<var>&lt;WorkloadName&gt;</var>-WorkloadUserPolicy</td>
      <td>Compute or workload users are allowed to use all compute instances for the workload. Workload users can also create console connections, launch instances on dedicated virtual machine hosts, and create images in the Partner Image catalog. Workload users cannot create custom images, and cannot use instance pools, autoscaling, or cluster networks.</td>
    </tr>
    <tr>
      <td>Workload-Storage-Admins</td>
      <td>OCI-LZ-<var>&lt;WorkloadName&gt;</var>-StorageAdminPolicy</td>
      <td>Storage administrators are allowed to manage all types of storage requirements for the workload, including Object Storage buckets and objects, File Storage resources, and Block Volume volumes and backups.</td>
    </tr>
    <tr>
      <td>Workload-Storage-Users</td>
      <td>OCI-LZ-<var>&lt;WorkloadName&gt;</var>-StorageUserPolicy</td>
      <td>Storage users are allowed to write and read from any Object Storage bucket in the associated workload compartment.</td>
    </tr>
    <tr>
      <td>Workload-Database-Admins</td>
      <td>OCI-LZ-<var>&lt;WorkloadName&gt;</var>-Database-Admin-Policy-Network</td>
      <td>Database admin users are allowed to manage databases, database storage, and networking.</td>
    </tr>
  </tbody>
</table>