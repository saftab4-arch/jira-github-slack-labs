# Lab 10 capstone — Terraform starter.
# Goal: deploy real AWS infra you know (VPC, or extend your TGW hub-spoke),
# applied by GitHub Actions using OIDC federation (NO long-lived AWS keys).
#
# Fill in the provider + a real resource during Lab 10.

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # backend "s3" { ... }   # optional: remote state in S3 + DynamoDB lock
}

provider "aws" {
  region = "us-east-1"
}

# --- Example placeholder resource. Replace with your real capstone infra. ---
# resource "aws_vpc" "lab" {
#   cidr_block = "10.50.0.0/16"
#   tags = { Name = "jira-github-slack-capstone" }
# }

# --- OIDC reminder (set up in AWS IAM, referenced from the workflow) ---
# 1. Create an IAM OIDC identity provider for token.actions.githubusercontent.com
# 2. Create an IAM role with a trust policy scoped to YOUR repo (sub condition).
# 3. In the workflow, request the role via aws-actions/configure-aws-credentials
#    with permissions: id-token: write  — no access keys stored anywhere.
