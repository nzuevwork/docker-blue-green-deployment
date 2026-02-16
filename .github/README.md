# Blue-Green Zero-Downtime Deployment (Docker + GitHub Actions)

Production-like DevOps project demonstrating **zero-downtime deployment** using Docker, Nginx and GitHub Actions self-hosted runner.

The system automatically deploys application updates from GitHub to a Linux server with no service interruption.

---

## Architecture

Developer → GitHub → GitHub Actions → Self-Hosted Runner → Docker → Nginx → Users

### Key Idea

Two identical environments exist simultaneously:

* **BLUE** – current production
* **GREEN** – next version

New code is deployed to the inactive environment.
Traffic switches only after a successful health check.

---

## Features

* Zero-downtime deployment
* Automatic deployment on push to `main`
* Self-hosted GitHub Actions runner
* Health checks before traffic switch
* Instant rollback capability
* No manual SSH during deployment
* No root privileges required

---

## Technology Stack

* Ubuntu Server
* Docker
* Docker Compose
* Nginx Reverse Proxy
* Bash automation
* GitHub Actions (CI/CD)

---

## CI/CD Pipeline

### Continuous Integration

Triggered on every push:

* Repository checkout
* Compose validation
* Build verification

### Continuous Deployment

1. Runner updates repository
2. Builds inactive environment
3. Runs health check
4. Switches Nginx traffic
5. Confirms service availability

---

## Deployment Flow

1. Push code to GitHub
2. GitHub Actions triggers
3. Self-hosted runner executes pipeline
4. Docker builds new container
5. Health check runs
6. Nginx switches traffic
7. Users see new version instantly

---

## Rollback

Rollback is immediate:

Traffic can be switched back to previous container (BLUE/GREEN) without rebuilding images.

---

## How to Run

On server:

```bash
git clone https://github.com/<your_username>/Blue-Greeen.git
cd Blue-Greeen
docker compose up -d
```

After this, every push to `main` automatically deploys the application.

---

## What I Implemented (DevOps Work)

* Configured Linux deployment server
* Created Dockerized application environments
* Implemented Blue-Green deployment logic
* Wrote Bash deployment automation scripts
* Configured Nginx reverse proxy switching
* Set up GitHub Actions self-hosted runner
* Built full CI/CD pipeline
* Implemented health-check validation
* Achieved zero-downtime releases

---

## Result

Application updates are deployed automatically without stopping the service.

This project simulates a real production deployment workflow used in modern DevOps environments.
