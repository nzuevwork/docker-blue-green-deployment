#!/bin/bash
set -e

echo "[+] Deploying BLUE environment"
docker compose -f docker-compose.blue.yml up -d --build
