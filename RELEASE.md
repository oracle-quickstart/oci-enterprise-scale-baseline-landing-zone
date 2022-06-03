## Release Notes


####06/03/2022 - Baseline Landing Zone Updates (Release 1.4.3)
* Add flag to control global resource deployment
* Update network admin policy to manage bastion in network compartment
* Add bastion subnet to flow logging
* Add CMK for audit log bucket
* Update provider version



####4/22/2022 - CIS Controls (Release 1.3.2)
* Remove default from security list examples
* Add notification service
* Separate tagging into a module
* Add consumption tags
* Separate VSS into a module
* Modify terraform version


####2/16/2022 - Baseline Landing Zone Updates (Release 1.2.1)

* Resolved Cloud Guard reporting region issue
* Resolved audit log retention days when not using audit logging

####2/04/2022 - Baseline Landing Zone Updates (Release 1.2.0)

* Enable compartment deletion (Sandbox Mode only)
* Hide administrator group from accidentally showing up in ORM
* Changed CloudGuard Detector recipes again - the CloudGuard service continues to rename these, and we're trying to keep up. We have a backlog item to make this more resilient.
* Allow audit logs to be as low as 1 day; default is now 1 day
* Updated bad variable name in example tfvars (advanced_logging)

####1/28/2022 - Baseline Landing Zone Updates (Release 1.1.0)

* Update zip file name to include date stamp (01282022)
* Terraform linting built into project
* Terraform version added to provider requirements
* The Administrator group is no longer created - instead we use the existing Administrator group, and add the break glass users to this group
* CloudGuard Detector recipes were renamed (on the backend) - value updated in CG config
* Better defaults for private and shared subnets, which are optional. Updated regular expression to allow empty value for when these subnets are not created.
* Finish rename for fss-subnet module in the top level vcn.tf file

####1/13/2022 - Baseline Landing Zone, initial LA release (Release 1.0.0)