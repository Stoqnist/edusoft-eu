#!/bin/bash

# S3 bucket setup script
# This script creates and configures S3 bucket for private video storage

# Configuration
BUCKET_NAME="XXXXXXXXXXXXXXXXXXXXXXXXX"
REGION="us-east-1"

# Create S3 bucket
echo "Creating S3 bucket: $BUCKET_NAME"
aws s3api create-bucket \
    --bucket $BUCKET_NAME \
    --region $REGION \
    --create-bucket-configuration LocationConstraint=$REGION

# Enable versioning
echo "Enabling versioning..."
aws s3api put-bucket-versioning \
    --bucket $BUCKET_NAME \
    --versioning-configuration Status=Enabled

# Enable server-side encryption
echo "Enabling encryption..."
aws s3api put-bucket-encryption \
    --bucket $BUCKET_NAME \
    --server-side-encryption-configuration '{
        "Rules": [
            {
                "ApplyServerSideEncryptionByDefault": {
                    "SSEAlgorithm": "AES256"
                }
            }
        ]
    }'

# Block public access
echo "Blocking public access..."
aws s3api put-public-access-block \
    --bucket $BUCKET_NAME \
    --public-access-block-configuration \
        BlockPublicAcls=true \
        IgnorePublicAcls=true \
        BlockPublicPolicy=true \
        RestrictPublicBuckets=true

echo "S3 bucket setup complete!"