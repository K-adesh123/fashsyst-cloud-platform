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

Repository setup is in progress.
Application development and cloud deployment have not started.

## Working approach

Build, test, document, and remove cloud resources after each
deployment session when they are no longer needed.

Use synthetic enquiry data during development.
Keep credentials, private keys, and Terraform state out of Git.