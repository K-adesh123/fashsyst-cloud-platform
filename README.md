# FASHSYST Cloud Platform
A DevOps portfolio project for deploying and operating a business enquiry API on AWS using Docker, Terraform, and GitHub Actions.

## Business purpose

The intended application will receive business enquiries, store them, and track their processing status.

The current application implements a health endpoint. Enquiry processing and database integration are planned.

## Current status

- FastAPI implements `GET /health` with an automated test.
- Docker packages the application and runs it as a non-root user.
- GitHub Actions tests the API, builds the image, and verifies container health.
- Terraform CI checks development infrastructure formatting and validity.
- Terraform provisions a VPC, two public subnets, and internet routing.
- Amazon ECR stores the application image with immutable tags.
- Amazon ECS Fargate runs the API with a container health check.
- An execution role grants access for image downloads and log delivery.
- CloudWatch collects container logs with seven-day retention.
- Inbound API access is restricted to a specified public IPv4 address.
- Development Terraform state uses S3 with versioning, encryption, and native state locking.
- AWS deployment was verified: task `RUNNING`, health `HEALTHY`, and `/health` returned `{"status":"ok"}`.
- The development service is currently paused with `desired_count = 0`.

AWS image publishing and Terraform deployment are currently performed manually. CI does not deploy to AWS.

## Architecture

- **Region:** `us-east-2`
- **Network:** VPC with two public subnets in separate Availability Zones.
- **Registry:** Amazon ECR.
- **Runtime:** One ECS Fargate task when enabled.
- **Application:** FastAPI listening on port `8000`.
- **Access:** Direct task public IP, with inbound access restricted to an allowed `/32` address.
- **Outbound traffic:** HTTPS for image downloads and log delivery.
- **Logs:** Amazon CloudWatch Logs.
- **Infrastructure state:** S3 backend with native locking.

This development setup has no load balancer, custom domain, HTTPS endpoint, or database yet. The task public IP can change when the task is replaced.

## Repository structure

- `app/` — Application code.
- `tests/` — Automated tests.
- `.github/workflows/` — API and Terraform CI workflows.
- `infrastructure/bootstrap/` — Terraform state bucket configuration.
- `infrastructure/environments/dev/` — Development AWS infrastructure.
- `docs/` — Troubleshooting notes and project documentation.

## Run locally with Docker

Run commands from the repository root.

Build the image:

```bash
docker build -t fashsyst-api:0.1 .
```

Start the container:

```bash
docker run -d --name fashsyst-api \
  -p 127.0.0.1:8000:8000 fashsyst-api:0.1
```

Check the endpoint:

```bash
curl -i http://127.0.0.1:8000/health
```

Expected: HTTP `200` with `{"status":"ok"}`.

View logs:

```bash
docker logs --tail 20 fashsyst-api
```

Stop and remove the local container:

```bash
docker stop fashsyst-api
docker rm fashsyst-api
```

## Check Terraform configuration

Authenticate with the configured AWS profile before operations that access AWS.

From the repository root:

```bash
terraform -chdir=infrastructure/environments/dev fmt -check
terraform -chdir=infrastructure/environments/dev validate
terraform -chdir=infrastructure/environments/dev plan
```

Review the plan before applying changes.

## Restart the development API

1. Confirm the security group ingress address matches your current public IPv4 address with `/32`.
2. In `infrastructure/environments/dev/ecs.tf`, set the ECS service to `desired_count = 1`.
3. Run Terraform plan and review the proposed changes.