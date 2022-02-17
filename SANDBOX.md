# oci-enterprise-scale-baseline-landing-zone-sandbox-mode 
The sandbox mode can be used for development or demonstration purposes. 

It adds a unique suffix for all the tenancy 
level resources which will allow multiple instances of the stack within the same tenancy.

Sandbox Mode limits the number of inputs by adding safe defaults. This includes:
- One workload
- Disabling Budgeting 
- Disabling the Public Subnet
- Disabling the Shared Services Subnet
- Setting safe defaults for VCN and Subnet configuration
- Enabling the Cloud Guard
- Enabling the Vulnerability Scanning Service
- Disabling the IPSEC Tunnel
- Disabling the FastConnect Virtual Circuit

## Requirements
- [Terraform](https://www.terraform.io/) >= 1.0.6

## Usage

An [tfvars file](examples/terraform.tfvars.sandbox.example) is included and will be required for the implementation. All the variables are set to safe defaults. 

The required inputs are: 
- Enable Advance Logging: This option allows you to enable Audit Logging and/or VCN Flow Logs 


## Deploy Using Oracle Resource Manager
1. From the home page of the [OCI Console](https://cloud.oracle.com/), under the Oracle Quickstarts, look for the "Deploy a baseline landing zone".

2. Review the deployment summary, and then select “Continue” to begin the deployment.

3. Enter the inputs and then select "Start deployment".

## Destroy Resources Using Oracle Resource Manager
1. If audit log bucket was provisioned, delete this bucket manually.
2. If flow logs were provisioned, delete these logs manually.
3. Go to the Stack Details page, then click Destroy.
4. A pop-up confirmation dialog page will appear. Click Destroy again.
5. Clean up leftover compartments in the OCI console.

## Deploy Using the Terraform CLI

### Clone the Module

Clone the source code from using the following command:
```
git clone ADD_URL_HERE
cd repository_name
```

### Running Terraform
Before running terraform apply, rename the [file](examples/terraform.tfvars.sandbox.example) from example directory to  
**terraform.tfvars** and save it in the outermost directory.

```
cp examples/terraform.tfvars.sandbox.example terraform.tfvars
```
Run the stack using the following commands:
```
terraform init
terraform plan
terraform apply
```

## Destroy Resources Using the Terraform CLI
1. If audit log buck was provisioned, delete this bucket manually.
2. If flow logs were provisioned, delete these logs manually.
3. Run the following commands to delete the stack:
```
terraform init
terraform destroy
```
4. Wait for Terraform to finish destroying resources.
5. Clean up leftover compartments in the OCI console.

### Terraform Variables
A complete listing of the Terraform variables used in this stack are referenced [here](VARIABLES.md). This document is automatically generated 
using the [terraform-docs](https://github.com/terraform-docs/terraform-docs) with the following command:

```
terraform-docs markdown table --sort-by required --show inputs --show outputs . > VARIABLES.md
```



## The Team
This repository was developed by the Oracle OCI Regulatory Solutions and Automation (RSA) team. 

## How to Contribute
Interested in contributing?  See our contribution [guidelines](CONTRIBUTE.md) for details.

## License
This repository and its contents are licensed under [UPL 1.0](https://opensource.org/licenses/UPL).
