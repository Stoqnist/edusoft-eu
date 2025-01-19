#!/bin/bash

# CloudFront distribution setup script
# This script creates CloudFront distribution for secure video delivery

# Configuration
BUCKET_NAME="XXXXXXXXXXXXXXXXXXXXXXXXX"
BUCKET_REGION="us-east-1"
OAC_ID="YOUR_OAC_ID_FROM_SCRIPT_1"

# Create CloudFront distribution configuration
cat > distribution-config.json << EOL
{
    "CallerReference": "$(date +%s)",
    "Origins": {
        "Quantity": 1,
        "Items": [
            {
                "Id": "S3-Videos",
                "DomainName": "${BUCKET_NAME}.s3.${BUCKET_REGION}.amazonaws.com",
                "OriginPath": "",
                "S3OriginConfig": {
                    "OriginAccessIdentity": ""
                },
                "OriginAccessControlId": "${OAC_ID}"
            }
        ]
    },
    "DefaultCacheBehavior": {
        "TargetOriginId": "S3-Videos",
        "ViewerProtocolPolicy": "redirect-to-https",
        "AllowedMethods": {
            "Quantity": 2,
            "Items": ["GET", "HEAD"],
            "CachedMethods": {
                "Quantity": 2,
                "Items": ["GET", "HEAD"]
            }
        },
        "CachePolicyId": "658327ea-f89d-4fab-a63d-7e88639e58f6",
        "OriginRequestPolicyId": "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf",
        "ResponseHeadersPolicyId": "67f7725c-6f97-4210-82d7-5512b31e9d03",
        "SmoothStreaming": false,
        "Compress": true
    },
    "Enabled": true,
    "Comment": "Video streaming distribution",
    "PriceClass": "PriceClass_100"
}
EOL

# Create CloudFront distribution
echo "Creating CloudFront distribution..."
DISTRIBUTION_ID=$(aws cloudfront create-distribution \
    --distribution-config file://distribution-config.json \
    --query 'Distribution.Id' \
    --output text)

echo "CloudFront distribution created with ID: $DISTRIBUTION_ID"
echo "Please wait 15-20 minutes for the distribution to deploy..."

# Clean up temporary file
rm distribution-config.json