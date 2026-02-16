# GitHub Actions CI/CD

This repository uses GitHub Actions to implement a Blue-Green deployment strategy.

## CI Pipeline
- Validates Dockerfile
- Validates docker-compose configurations
- Runs on pull requests and pushes

## CD Pipeline
- Triggers on push to `main`
- Deploys GREEN environment first
- Runs health checks
- Switches traffic via Nginx
- Supports rollback without downtime

## Security
- No credentials stored in repository
- SSH access via GitHub Secrets
- No root access required

## Deployment Strategy
Blue-Green deployment ensures zero downtime and fast rollback.

