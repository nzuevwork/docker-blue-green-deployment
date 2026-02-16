## What this project demonstrates

This project implements a **zero-downtime deployment strategy (Blue-Green Deployment)** using Docker and Nginx reverse proxy.

The system maintains two identical application environments:

* BLUE (active)
* GREEN (standby)

A new version is deployed to the inactive environment, verified via health-check, and only then traffic is switched.

This simulates real production release processes used in companies to avoid service outages during deployments.

Key features:

* zero downtime releases
* health-checked deployments
* instant rollback
* traffic switching via reverse proxy
* release safety verification
## Architecture

User → Nginx reverse proxy → active environment (blue or green)

Deployment flow:

1. New version is deployed to inactive environment
2. Health check is executed
3. If healthy → traffic switch
4. If failed → rollback to previous version
