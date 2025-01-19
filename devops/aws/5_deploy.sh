#!/bin/bash

# Main deployment script
# This script orchestrates the entire deployment process

echo "Starting deployment process..."

# 1. Initialize AWS account
echo "Step 1: Initializing AWS account..."
./1_aws_init.sh
if [ $? -ne 0 ]; then
    echo "AWS initialization failed!"
    exit 1
fi

# 2. Setup S3 bucket
echo "Step 2: Setting up S3 bucket..."
./2_s3_setup.sh
if [ $? -ne 0 ]; then
    echo "S3 bucket setup failed!"
    exit 1
fi

# 3. Setup CloudFront distribution
echo "Step 3: Setting up CloudFront distribution..."
./3_cloudfront_setup.sh
if [ $? -ne 0 ]; then
    echo "CloudFront setup failed!"
    exit 1
fi

# 4. Setup static page
echo "Step 4: Setting up static page..."
./4_static_page_setup.sh
if [ $? -ne 0 ]; then
    echo "Static page setup failed!"
    exit 1
fi

echo "Deployment completed successfully!"
echo "Next steps:"
echo "1. Push the static page to GitHub repository"
echo "2. Enable GitHub Pages for the repository"
echo "3. Update the video player's API endpoint with your backend service"
echo "4. Start uploading videos to the S3 bucket"
echo "5. Test the video playback using the CloudFront distribution"