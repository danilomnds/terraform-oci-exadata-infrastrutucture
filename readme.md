# Module - Oracle Exadata Infrastructure
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![OCI](https://img.shields.io/badge/provider-OCI-red)](https://registry.terraform.io/providers/oracle/oci/latest)

Module developed to standardize the creation of Oracle Exadata Infrastructure.

## Compatibility Matrix

| Module Version | Terraform Version | OCI Version     |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.9.5            | 6.8.0           |

## Specifying a version

To avoid that your code get the latest module version, you can define the `?ref=***` in the URL to point to a specific version.
Note: The `?ref=***` refers a tag on the git module repo.

## Default use case
```hcl
module "exa-<region>-<env>-<system>-<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-exadata-infrastrutucture?ref=v1.0.0"
  compartment_id = <compartment id>
  display_name = "exa-vcp-prd-coe-001"
  shape = "Exadata.X9M"
  compute_count = 2
  storage_count = 3
  customer_contacts = [
    {
      email = "email1"
    },
    {
      email = "email2"
    },
    {
      email = "email3"
    },
  ]
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }
}
output "display-name" {
  value = module.exa-<region>-<env>-<system>-<id>.name
}
output "exadata-id" {
  value = module.exa-<region>-<env>-<system>-<id>.id
}
```

## Default use case plus RBAC
```hcl
module "exa-<region>-<env>-<system>-<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-exadata-infrastrutucture?ref=v1.0.0"
  compartment_id = <compartment id>
  display_name = "exa-vcp-prd-coe-001"
  shape = "Exadata.X9M"
  compute_count = 2
  storage_count = 3
  customer_contacts = [
    {
      email = "email1"
    },
    {
      email = "email2"
    },
    {
      email = "email3"
    },
  ]
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }
  compartment = <compartment name>
  # GRP_OCI_APP-ENV is the Azure AD group that you are going to grant the permissions
  groups = ["OracleIdentityCloudService/GRP_OCI_APP-ENV", "group name 2"]
}
output "display-name" {
  value = module.exa-<region>-<env>-<system>-<id>.name
}
output "exadata-id" {
  value = module.exa-<region>-<env>-<system>-<id>.id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability_domain | the availability domain where the cloud exadata infrastructure is located | `string` | n/a | `Yes` |
| cluster_placement_group_id | the ocid of the cluster placement group of the exadata infrastructure | `string` | n/a | No |
| compartment_id | the ocid of the compartment | `string` | n/a | `Yes` |
| compute_count | the number of compute servers for the cloud exadata infrastructure | `number` | n/a | no |
| customer_contacts | the email address used by oracle to send notifications regarding databases and infrastructure | `list(object{})` | `DLs UNIX, Database e Cloud Resources` | No |
| defined_tags | Defined tags for this resource | `map(string)` | n/a | No |
| display_name | the user-friendly name for the cloud exadata infrastructure resource | `string` | n/a | `Yes` |
| freeform_tags | Free-form tags for this resource | `map(string)` | n/a | No |
| maintenance_window | a block as defined below | `object({})` | n/a | No |
| shape | the shape of the cloud exadata infrastructure resource | `string` | n/a | `Yes` |
| storage_count | the number of storage servers for the cloud exadata infrastructure | `number` | n/a | No |
| groups | list of azure AD groups that will manage objects inside the bucket | `list(string)` | n/a | No |
| subscription_id | the ocid of the subscription with which resource needs to be associated with | `string` | n/a | No |
| compartment | compartment name that will be used for policy creation | `string` | n/a | No |
| enable_group_access | enables the policy creation. If true the groups var should have a least one value | `bool` | `true` | No |

# Object variables for blocks

| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| maintenance_window | custom_action_timeout_in_mins | determines the amount of time the system will wait before the start of each database server patching operation  | `number` | n/a | No |
| maintenance_window | optional sub-block days_of_week (name) | name of the day of the week  | `String` | n/a | No |
| maintenance_window | hours_of_day | The window of hours during the day when maintenance should be performed | `number` | n/a | No |
| maintenance_window | is_custom_action_timeout_enabled |  If true, enables the configuration of a custom action timeout (waiting period) between database server patching operations | `bool` | n/a | No |
| maintenance_window | is_monthly_patching_enabled | if true, enables the monthly patching option | `bool` | n/a | no |
| maintenance_window | lead_time_in_weeks | lead time window allows user to set a lead time to prepare for a down time | `number` | n/a | no |
| maintenance_window | optional sub-block months (name) | name of the month of the year  | `string` | n/a | no |
| maintenance_window | patching_mode | cloud exadata infrastructure node patching method, either "rolling" or "nonrolling" | `string` | n/a | no |
| maintenance_window | preference | the maintenance window scheduling preference | `string` | n/a | no |
| maintenance_window | weeks_of_month | weeks during the month when maintenance should be performed | `number` | n/a | no |


## Output variables

| Name | Description |
|------|-------------|
| name | exadata infrastructure name|
| id | exadata infrastructure id |

## Documentation
Oracle Exadata Infrastructure: <br>
[https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_cloud_exadata_infrastructure](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_cloud_exadata_infrastructure)