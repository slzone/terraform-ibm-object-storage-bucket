#output "myoutput" {
#  description = "Description of my output"
#  value       = "value"
#  depends_on  = [<some resource>]
#}

output "cos_instance_id" {
  description = "The ID of the cos instance"
  value = length(ibm_resource_instance.cos_instance) > 0 ? ibm_resource_instance.cos_instance[0].id : ""
}

output "cos_bucket_id" {
  description = "The ID of the cos instance"
  value = length(ibm_cos_bucket.bucket_instance) > 0 ? ibm_cos_bucket.bucket_instance[0].id : ""
}
