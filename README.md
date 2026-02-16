# Docker Blue-Green Deployment

This project demonstrates a **Blue-Green deployment strategy** using Docker and Nginx
to achieve zero-downtime deployments and safe rollbacks.

## Concept
- Two identical application environments: **blue** and **green**
- Only one environment receives production traffic
- New versions are deployed to the inactive environment
- Traffic is switched only after verification

## Stack
- Docker
- Docker Compose
- Nginx (reverse proxy)
- Bash automation scripts

## Deployment Flow
1. Deploy new version to inactive environment
2. Validate application health
3. Switch Nginx traffic
4. Roll back instantly if needed

## Use cases
- Production deployments
- CI/CD pipelines
- Zero-downtime upgrades
- Safe rollback strategy

---

## Quick start
```bash
docker compose -f docker-compose.nginx.yml up -d
./scripts/deploy_blue.sh
./scripts/switch_traffic.sh blue
