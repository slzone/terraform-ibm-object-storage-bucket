resource null_resource print_names {
  provisioner "local-exec" {
    command = "echo 'Resource group: ${var.resource_group_name}'"
  }
}

data "ibm_resource_group" "resource_group" {
  depends_on = [null_resource.print_names]

  name = var.resource_group_name
}

# COS instance 
data "ibm_resource_instance" "cos_instance" {
    resource_group_id = data.ibm_resource_group.resource_group.id
    name              = "slz-rg-cos"
    service           = "cloud-object-storage"
    location          = var.resource_location
}

# HPCS instance 
data "ibm_resource_instance" "hpcs_instance" {
    resource_group_id = data.ibm_resource_group.resource_group.id
    name              = var.hpcs_instance_name
}

# KMS key managed by HPCS
data "ibm_kms_key" "kmskey" {
   instance_id  = data.ibm_resource_instance.hpcs_instance.guid
    key_name    = var.key_name
}

#COS bucket provision
locals {
  prefix_name = var.name_prefix != "" ? var.name_prefix : var.resource_group_name
  bucket_name = lower(replace(var.name != "" ? var.name : "${var.resource_group_name}-cos-bucket", "_", "-"))
}

resource "ibm_cos_bucket" "bucket_instance" {
  count                   = (var.provision ? 1 : 0)
  bucket_name             = local.bucket_name
  resource_instance_id    = data.ibm_resource_instance.cos_instance.id
  region_location         = var.region_location
  storage_class           = var.storage_class
  key_protect             = data.ibm_kms_key.kmskey.keys[0].crn
}



