 # Terraform script to create an S3 bucket

    # Create a file named `main.tf` with the following content:

    provider "aws" {
        region     = "us-west-2"
        access_key = "AKIAQWSCNYGR2CKQCAO7"
        secret_key = "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"
      }

      resource "aws_s3_bucket" "bucket" {
        bucket = "dv-scraping-bucket"
      }
      
      resource "aws_s3_bucket_versioning" "versioning" {
        bucket = aws_s3_bucket.bucket.id
        versioning_configuration {
          status = "Enabled"
        }
      }
      
      resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
        bucket = aws_s3_bucket.bucket.id
        rule {
          apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
          }
        }
      }
      
      resource "aws_s3_bucket_ownership_controls" "ownership" {
        bucket = aws_s3_bucket.bucket.id
        rule {
          object_ownership = "BucketOwnerPreferred"
        }
      }
      
      resource "aws_s3_bucket_acl" "acl" {
        depends_on = [aws_s3_bucket_ownership_controls.ownership]
        bucket = aws_s3_bucket.bucket.id
        acl    = "private"
      }
      
      resource "aws_s3_bucket_public_access_block" "public_access" {
        bucket = aws_s3_bucket.bucket.id
        block_public_acls       = true
        block_public_policy     = true
        ignore_public_acls      = true
        restrict_public_buckets = true
      }
