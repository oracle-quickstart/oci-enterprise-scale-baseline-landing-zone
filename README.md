# oci-rsa-baseline-landing-zone
This Terraform stack deploys a baseline landing zone.

## Requirements
- [Terraform](https://www.terraform.io/) >= 1.0.6

## Prerequisites
Detailed project prerequisites are included in the following [Architecture Documentation](PLACEHOLDER)

## Usage

An example [tfvars file](examples/terraform.tfvars.example) is included for reference. This file is arranged according to 
category a particular variable belongs to. Not all the variables in this file are required.

## Deploy Using Oracle Resource Manager
1. Click to deploy the stack
   
[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-quickstart/oci-rsa-baseline-landing-zone/releases/download/latest/oci-rsa-baseline-landing-zone.zip)

    If you aren't already signed in, when prompted, enter the tenancy and user credentials. Review and accept the terms and conditions.


2. Select the region where you want to deploy the stack.

3. Follow the on-screen prompts and instructions to create the stack.

4. After creating the stack, click Terraform Actions, and select Plan.

5. Wait for the job to be completed, and review the plan.

6. To make any changes, return to the Stack Details page, click Edit Stack, and make the required changes. Then, run the Plan action again.

7. If no further changes are necessary, return to the Stack Details page, click Terraform Actions, and select Apply.


## Deploy Using the Terraform CLI

### Prerequisites
Create a terraform.tfvars file and populate with the required variables or override existing variables.

Note: An example [tfvars file](examples/terraform.tfvars.example) is included for reference. Using this file is the 
preferred way to run the stack from the CLI, because of the large number of variables to manage.

To use this file just copy the example [tfvars file](examples/terraform.tfvars.example) and save it in the outermost directory.
Next, rename the file to **terraform.tfvars**. You can override the example values set in this file.

### Clone the Module

Clone the source code from suing the following command:
```
git clone ADD_URL_HERE
cd repository_name
```

### Running Terraform
After specifying the required variables you can run the stack using the following command:
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

## Sandbox Mode

The sandbox mode is an alternate deployment method that can be used for development or demonstration purposes. 

For more information follow this [link](SANDBOX.md).

## The Team
This repository was developed by the Oracle OCI Regulatory Solutions and Automation (RSA) team. 

## How to Contribute
Interested in contributing?  See our contribution [guidelines](CONTRIBUTE.md) for details.

## License
This repository and its contents are licensed under [UPL 1.0](https://opensource.org/licenses/UPL).