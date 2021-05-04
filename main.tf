resource null_resource print_names {
  provisioner "local-exec" {
    command = "echo 'Resource group: ${var.resource_group_name}'"
  }
}

data "ibm_resource_group" "resource_group" {
  depends_on = [null_resource.print_names]

  name = var.resource_group_name
}

# COS instance decalared
data "ibm_resource_instance" "cos_instance" {
    resource_group_id = data.ibm_resource_group.resource_group.id
    name              = "slz-rg-cos"
    service           = "cloud-object-storage"
    #plan             = var.plan
    location          = var.resource_location
}

# HPCS instance deaclared
data "ibm_resource_instance" "hpcs_instance" {
    resource_group_id = data.ibm_resource_group.resource_group.id
    name              = var.hpcs_instance_name
    #service          = var.hpcs_instance_name
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
  cross_region_location   = var.region
  storage_class           = var.storage_class
  key_protect             = data.ibm_kms_key.kmskey.id
}

/*** resource "ibm_iam_authorization_policy" "policy" {
  #resource_group_id            = data.ibm_resource_group.rg_name.id
  depends_on                    = [ibm_cos_bucket.bucket_instance]
  source_service_name           = "cloud-object-storage"
  #source_resource_instance_id  = ibm_resource_instance.cos_instance.id
  target_service_name           = "hpcs"
  #target_resource_instance_id  = ibm_resource_instance.hpcs_instance.id
  roles                         = ["Reader"]
} ***/
