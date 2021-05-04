# terraform-ibm-object-storage-bucket-encryption

This terraforms module Provisions an IBM Cloud Object Storage instance and creates a COS bucket with encryption.

•	Provision COS instance
•	Create a COS bucket with encryption(HPCS)


## Module dependencies

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group.git
- Object storage - github.com/ibm-garage-cloud/terraform-ibm-object-storage.git
- HPCS instance  - github.com/slzone/terraform-ibm-hpcs.git



To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources. 

## Example usage

```hcl-terraform
resource "ibm_cos_bucket" "bucket_instance" {
  count                   = (var.provision ? 1 : 0)
  bucket_name             = local.bucket_name
  resource_instance_id    = data.ibm_resource_instance.cos_instance.id
  region_location         = var.region_location
  storage_class           = var.storage_class
  key_protect             = data.ibm_kms_key.kmskey.keys[0].crn
```

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | ~> 0.13   |
| OS        | Mac/Linux |


## Providers

| Name | Version |
|------|---------|
| ibm  |  n/a    |


## Inputs

| Name              | Description                                     | Type     | Required | 
|-------------------|-------------------------------------------------|----------|----------|
|  bucket_name      | COS bucket name.                                | `string` |   yes    |  
|  storage_class	  | Storage class to use for the bucket.	          | `string` |   yes    |  
|  Location	        | The location of a regional bucket               | `string` |   yes    |                        
|  plan             | The name of the plan type supported by service. | `string` |   yes    |  
|  resource_group   | Name of the resource group                      | `string` |   yes    |  
|  region_location  | location of the bucket.                         | `string` |   Yes    |
|  key_protect      | Encryption key for bucket                       | `string` |   Yes    |



## Outputs

| Name              | Description                   | Type     | Required |
|-------------------|-------------------------------|----------|----------|
| cos_instance_id   | The id cos instance           |`string`  |   Yes    |
| bucket_name       | COS bucket name.              | `string` |   Yes    |



