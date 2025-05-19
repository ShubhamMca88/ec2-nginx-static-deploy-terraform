# Terraform Automation: Static Website Deployment on AWS EC2 & Nginx

[![GitHub](https://img.shields.io/badge/GitHub-aws--terraform--ec2-blue)](https://github.com/shubham/aws-terraform-ec2)

This project automates the deployment of a static website using AWS EC2, Nginx web server, and GitHub integration through Terraform.

## Overview

- **Terraform Automation**: Complete infrastructure provisioning and management
- **Static Website Hosting**: Deploy static websites on AWS EC2
- **Nginx Web Server**: Fast and reliable web server configuration
- **GitHub Integration**: Automated deployment from GitHub repository

## Architecture

- EC2 instance running Nginx web server
- Elastic IP for static public IP
- Security groups for web traffic (HTTP/HTTPS)
- VPC and subnet configuration
- Automated Nginx installation and configuration

## Prerequisites

- AWS Account and CLI configured
- GitHub repository with static website code
- Terraform installed
- SSH key pair

## Quick Deployment

1. Configure AWS credentials:
   ```bash
   aws configure
   ```

2. Update `terraform.tfvars`:
   ```hcl
   instance_name = "static-website"
   instance_type = "t2.micro"
   ```

3. Deploy infrastructure:
   ```bash
   terraform init
   terraform apply
   ```

## Website Deployment

1. Clone your static website repository to the EC2 instance
2. Configure Nginx to serve your static files
3. Access your website using the Elastic IP

## Features

- Automated EC2 instance provisioning
- Nginx web server setup
- Static IP address allocation
- Secure networking configuration
- Automated website deployment

## Maintenance

- Monitor EC2 instance status
- Update Nginx configuration as needed
- Manage SSL certificates
- Regular security updates

## Cleanup

Remove all resources:
```bash
terraform destroy
```

## License

MIT License 