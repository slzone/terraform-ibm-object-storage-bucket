variable "resource_group_name" {
  description = "The name of the IBM Cloud resource group where the VPC instance will be created."
  type        = string
  default     = "slz-rg"
}

variable "cos_instance_name" {
   description = "The name of COS Instance"
   type        = string
   default     = "slz-rg-cos"
}

variable "service" {
   description = "The name of service"
   type        = string
   default     = "cloud-object-storage"
}

variable "resource_location" {
   description = "The location of COS instance"
   type        = string
   default     = "global"
}

variable "hpcs_instance_name" {
   description = "The name of HPCS Instance"
   type        = string
   default     = "Hyper Protect Crypto Services-mrshah"
}

variable "service_name" {
   description = "The name of HPCS Instance"
   type        = string
   default     = "Hyper Protect Crypto Services-mrshah"
}

variable "key_name" {
  description = "The kms key name"
  type        = string
  default     = "Ref architecture test key"
}

 # COS bucket variables
variable "provision" {
    description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
    type        = bool
    default     = true
}

variable "cos_instance_id" {
    description = "id of the COS instance"
    type        = string
    default     = ""
}

variable "name_prefix" {
  type        = string
  description = "The name of the cos resource"
  default     = ""
}

variable "name" {
    description = "Name of the bucket"
    type        = string
    default     = "cloud-s-12"
}

variable "region" {
    description = "Cross-regional bucket location. Supported values are us, eu, and ap.  Default 'us'"
    type        = string
    default     = "us"
}

variable "storage_class" {
    description = "Storage class of the bucket. Supported values are standard, vault, cold, flex, smart."
    type        = string
    default     = "standard"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud api token"
  default="jKHN9mBu8Cp2q6-b_00Muz5n7398hChKQlj6bfnA9Czl"
}
