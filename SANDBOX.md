# oci-rsa-baseline-landing-zone-sandbox-mode 
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
1. Click to deploy the stack
   
   [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](PLACEHOLDER)
   
    If you aren't already signed in, when prompted, enter the tenancy and user credentials. Review and accept the terms and conditions.


2. Select the region where you want to deploy the stack.

3. Follow the on-screen prompts and instructions to create the stack.

4. After creating the stack, click Terraform Actions, and select Plan.

5. Wait for the job to be completed, and review the plan.

6. To make any changes, return to the Stack Details page, click Edit Stack, and make the required changes. Then, run the Plan action again.

7. If no further changes are necessary, return to the Stack Details page, click Terraform Actions, and select Apply.


## Deploy Using the Terraform CLI

### Clone the Module

Clone the source code from suing the following command:
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