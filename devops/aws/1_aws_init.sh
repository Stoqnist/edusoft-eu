#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source the .env file using absolute path
0_source_env.sh

# Now you can use the environment variables
echo "Deploy in: $REGION"

# AWS Account initialization script
# This script sets up initial AWS configuration and required IAM roles/policies

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if credentials are configured
if ! aws configure list &> /dev/null; then
    echo "AWS credentials not configured. Please run 'aws configure' first."
    exit 1
fi

# Create IAM roles and policies
echo "Creating IAM roles and policies..."

echo $VAR

# Create S3 bucket policy for CloudFront access
cat > devops/aws/s3-cloudfront-policy.json << EOL
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::VIDEO_BUCKET_NAME/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::ACCOUNT_ID:distribution/DISTRIBUTION_ID"
                }
            }
        }
    ]
}
EOL

# Create Origin Access Control policy
echo "Creating Origin Access Control..."
OAC_ID=$(aws cloudfront create-origin-access-control \
    --origin-access-control-config \
        Name="S3-Video-OAC" \
        Description="OAC for S3 video bucket" \
        SigningProtocol=sigv4 \
        SigningBehavior=always \
        OriginAccessControlOriginType=s3 \
    --query 'OriginAccessControl.Id' \
    --output text)

echo "Origin Access Control ID: $OAC_ID"
echo "Please update the S3 bucket policy and CloudFront distribution config with the correct values."
