 # Terraform script to create an S3 bucket

    # Create a file named `main.tf` with the following content:

    provider "aws" {
        region = "us-west-2"
    }

    resource "aws_s3_bucket" "my_bucket" {
        bucket = "your-s3-bucket-name"
        acl    = "private"

        tags = {
            Name        = "My bucket"
            Environment = "Dev"
        }
    }

    # Save the file and run the following commands in your terminal:

    # Initialize the Terraform configuration
    terraform init

    # Apply the Terraform configuration to create the S3 bucket
    terraform apply