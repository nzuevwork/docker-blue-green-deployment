# GitHub Actions Pipeline

This repository uses GitHub Actions with a self-hosted runner.

## Trigger

* Push to `main`

## Runner

* Self-hosted Linux server

## Job

1. Update repository
2. Build inactive environment
3. Run health check
4. Switch Nginx traffic
5. Verify deployment

The runner performs deployment directly on the target server.
