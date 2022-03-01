resource "aws_s3_bucket" "demos3" {
    bucket = lower(var.bucket_name)
    acl = var.acl_value 
    
    tags = {
    Name = var.bucket_name 
    Date = timestamp()
    } 
}
