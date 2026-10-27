# FASHSYST Cloud Platform

A DevOps portfolio project for deploying and operating a
business enquiry API on AWS.

## Business purpose

Receive business enquiries, store them, and track their
processing status.

## Engineering goals

- Provision AWS infrastructure using Terraform.
- Package the API in Docker.
- Automate testing, image builds, and deployment.
- Configure secure access between services.
- Monitor application health and investigate failures.
- Test backup restoration and deployment recovery.
- Document costs, design decisions, and cleanup procedures.

## Planned technologies

Python, Docker, GitHub Actions, Terraform, AWS, and PostgreSQL.

Specific AWS services will be selected during architecture design,
considering account availability and cost.

## Repository structure

- app/ — Application code.
- tests/ — Automated tests.
- infrastructure/environments/dev/ — Development infrastructure.
- docs/ — Architecture, decisions, runbooks, and test evidence.

## Current status

- FastAPI application implements GET /health.
- Automated health endpoint test passes.
- Docker image builds successfully.
- Container runs locally as a non-root user.
- Container endpoint returns HTTP 200 and {"status":"ok"}.
- Troubleshooting notes document test discovery and Docker connectivity fixes.

Cloud deployment and CI automation are planned.
## Run with Docker

From the repository root, build the image:

```bash
docker build -t fashsyst-api:0.1 .
```

Start the container:

```bash
docker run -d --name fashsyst-api -p 127.0.0.1:8000:8000 fashsyst-api:0.1
```

Check the endpoint:

```bash
curl -i http://127.0.0.1:8000/health
```

Expected result: HTTP 200 with {"status":"ok"}.

View application logs:

```bash
docker logs --tail 20 fashsyst-api
```

Stop and remove the container when finished:

```bash
docker stop fashsyst-api
docker rm fashsyst-api
```