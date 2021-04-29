variable "resource_group_name" {
  type        = string
  description = "The name of the IBM Cloud resource group where the VPC instance will be created."
}

variable "provision" {
    description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
    type        = bool
    default = true
}


## cos instance vars

variable "name" {
    description = "Name of the COS instance"
    type        = string
    default     = ""
}

variable "name_prefix" {
  type        = string
  description = "The name of the cos resource"
  default     = ""
}

variable "plan" {
    description = "Plan for the Cloud Object Storage instance"
    type        = string
    default     = "standard"
}


variable "location" {
    description = "COS Location location. Default 'global'"
    type        = string
    default     = "global"
}


## bucket vars

variable "bucket_name" {
    description = "Name of the bucket"
    type        = string
    default     = ""
}


variable "bucket_region" {
    description = "Cross-regional bucket location. Supported values are us, eu, and ap.  Default 'us'"
    type        = string
    default     = "us"
}

variable "storage_class" {
    description = "Storage class of the bucket. Supported values are standard, vault, cold, flex, smart."
    type        = string
    default     = "standard"
}


## other variables
variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud api token"
}

