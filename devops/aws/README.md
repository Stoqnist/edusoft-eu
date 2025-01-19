# AWS Video Content Delivery Setup

This collection of scripts sets up a secure video content delivery system using AWS S3, CloudFront, and a static GitHub Pages website.

## Components

1. **AWS Account Setup** (1_aws_init.sh)
   - Configures AWS CLI
   - Sets up IAM roles and policies
   - Creates Origin Access Control for CloudFront

2. **S3 Bucket Setup** (2_s3_setup.sh)
   - Creates private S3 bucket
   - Enables versioning and encryption
   - Configures bucket policies

3. **CloudFront Setup** (3_cloudfront_setup.sh)
   - Creates CloudFront distribution
   - Configures security settings
   - Sets up Origin Access Control

4. **Static Page Setup** (4_static_page_setup.sh)
   - Creates HTML5 video player page
   - Includes necessary styling and scripts
   - Generates deployment instructions

5. **Deployment Script** (5_deploy.sh)
   - Orchestrates the entire deployment process
   - Runs all scripts in sequence
   - Provides next steps and verification

## Prerequisites

1. AWS CLI installed and configured
2. GitHub account
3. Bash shell environment
4. Required permissions in AWS account

## Usage

1. Update configuration variables in each script:
   - BUCKET_NAME
   - REGION
   - OAC_ID
   - DISTRIBUTION_ID

2. Make scripts executable:
   ```bash
   chmod +x *.sh
   ```

3. Run the deployment script:
   ```bash
   ./5_deploy.sh
   ```

4. Follow the post-deployment instructions for GitHub Pages setup.

## Security Features

- Private S3 bucket with blocked public access
- CloudFront Origin Access Control
- HTTPS-only content delivery
- Server-side encryption for S3 objects
- Signed URLs for video access

## Maintenance

- Regularly rotate CloudFront key pairs
- Monitor S3 bucket for unauthorized access attempts
- Update security policies as needed
- Keep video player code updated with security patches