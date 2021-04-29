module "dev_cos" {
  source = "./module"

  resource_group_name = module.resource_group.name
  name_prefix         = var.name_prefix
  ibmcloud_api_key    = var.ibmcloud_api_key
}
