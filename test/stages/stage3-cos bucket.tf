resource null_resource print_cos_id {
  depends_on = [module.cos.id]
  provisioner "local-exec" {
    command = "echo 'Provisioning bucket into COS instance: ${module.cos.id}'"
  }
}

module "dev_cos_bucket" {
  source = "./module"

  resource_group_name = module.resource_group.name
  cos_instance_id     = module.cos.id
  name_prefix         = var.name_prefix
  ibmcloud_api_key    = var.ibmcloud_api_key
  name                = "my-test-bucket"
}
