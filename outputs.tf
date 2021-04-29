output "bucket_name" {
  description = "The name of the COS bucket instance"
  value = length(ibm_cos_bucket.bucket_instance) > 0 ? ibm_cos_bucket.bucket_instance[0].bucket_name : ""
}


output "id" {
  description = "The ID of the COS bucket instance"
  value = length(ibm_cos_bucket.bucket_instance) > 0 ? ibm_cos_bucket.bucket_instance[0].id : ""
}
