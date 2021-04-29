resource null_resource print_names {
  provisioner "local-exec" {
    command = "echo 'Resource group: ${var.resource_group_name}'"
  }
}

data "ibm_resource_group" "resource_group" {
  depends_on = [null_resource.print_names]

  name = var.resource_group_name
}

locals {
  prefix_name       = var.name_prefix != "" ? var.name_prefix : var.resource_group_name
  cos_name          = lower(replace(var.name != "" ? var.name : "${local.prefix_name}-cos", "_", "-"))
  bucket_name       = lower(replace(var.bucket_name != "" ? var.bucket_name : "${local.cos_name}-bucket", "_", "-"))
}



resource "ibm_resource_instance" "cos_instance" {
  count             = (var.provision ? 1 : 0)
  name              = local.cos_name
  resource_group_id = data.ibm_resource_group.resource_group.id
  service           = "cloud-object-storage"
  location          = var.location
  plan              = var.plan
}
resource null_resource print_cos_id {
  depends_on = [ibm_resource_instance.cos_instance]
  provisioner "local-exec" {
    command = "echo 'Provisioned COS instance: ${local.cos_name} with id: ${ibm_resource_instance.cos_instance[0].id}'"
  }
}

# data "ibm_resource_instance" "cos_instance" {
#   name              = local.cos_name
#   resource_group_id = data.ibm_resource_group.resource_group.id
# }

resource "ibm_cos_bucket" "bucket_instance" {
  depends_on = [ibm_resource_instance.cos_instance, null_resource.print_cos_id]

  count             = (var.provision ? 1 : 0)
  bucket_name             = local.bucket_name
  resource_instance_id    = length(ibm_resource_instance.cos_instance) > 0 ? ibm_resource_instance.cos_instance[0].id : ""
  cross_region_location   = var.bucket_region
  storage_class           = var.storage_class
}