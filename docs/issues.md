# Prerequisites

1. If it's your first time using OCI, please make sure to manually enable the service below before running the Landing Zone stack:

    - Cloud Guard: https://docs.oracle.com/en-us/iaas/cloud-guard/using/prerequisites.htm
    - Logging Analytics: https://docs.oracle.com/en-us/iaas/logging-analytics/doc/enable-access-logging-analytics-and-its-resources.html

2. Create a terraform.tfvars file and populate with the required variables or override existing variables. Note: An example tfvars file is included for reference. Using this file is the preferred way to run the stack from the CLI, because of the large number of variables to manage. 

    - To use this file just copy the example tfvars file and save it in the outermost directory.
    - Next, rename the file to terraform.tfvars.
    - You can override the example values set in this file.

# Known Issues

1. 409 Error Policy Already Exists
```
│ Error: 409-PolicyAlreadyExists 
│ Provider version: 4.70.0, released on 2022-04-07. This provider is 3 Update(s) behind to current. 
│ Service: Identity Policy 
│ Error Message: Policy 'oci-lz-cloud-guard-policy' already exists 
│ OPC request ID: d1e672cb1c917ec614db286db8f11d48/0D086E82994A22E3E8C6DCC7B0FB9265/13BC915A63EAB71F13DA5ABD23EF77BC 
│ Suggestion: The resource is in a conflicted state. Please retry again or contact support for help with service: Identity Policy
```
If you already run the Landing Zone stack once and try to run another stack in another region, the 409 Error Policy Already Exists would show above. This is because the policies were created at the tenancy level. We are planning to add a flag to avoid this error happen.


2. 400 Insufficient Service Permission.

That might be the edge case of Terraform. Try to run "terraform apply" again to solve this issue.


3. 400 Invalid Retention Rule Details
```
│ Error: 400-InvalidRetentionRuleDetails
│ Provider version: 4.70.0, released on 2022-04-07. This provider is 5 Update(s) behind to current.
│ Service: Object Storage Bucket
│ Error Message: timeRuleLocked must be atleast 14 days ahead of the current time.
│ OPC request ID: iad-1:yxFRsJ5Km_ZB9ALv5vYnr7CGmmy22xRxHRCzpiiZtqK5zoZdB4yZj1BgZrUd8NUZ
│ Suggestion: Please retry or contact support for help with service: Object Storage Bucket
```
You may counter this issue if you delete the audit log bucket and recreate one through terraform. This is because the time offset (15 days as default) was created when the first time you run terraform apply. It may not be 14 days ahead at the time you recreate the bucket. To solve this issue, you can either recreate the time offset or manually create a retention rule in OCI console. 

 
