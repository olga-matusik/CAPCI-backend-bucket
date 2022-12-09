#creating S3 bucket resource
resource "aws_s3_bucket" "CAPCI_gr1" {
    bucket = "capci-gr1-project-backend-406843093389"

    lifecycle {
      prevent_destroy = true
    }

    tags = {
        Name = "capci-gr1-project-backend-406843093389"
    }
}

#assigning bucket versioning to the bucket
resource "aws_s3_bucket_versioning" "version_my_bucket" {
  bucket = aws_s3_bucket.CAPCI_gr1.id

  versioning_configuration {
    status = "Enabled"
  }
}

#creating DynamoDB to manage a lock file to prevent multiple parallel deployment
resource "aws_dynamodb_table" "terraform_lock_tbl" {
  name           = "CAPCI-terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags           = {
    Name = "CAPCI-terraform-lock"
  }
}