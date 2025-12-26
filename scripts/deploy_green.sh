#!/bin/bash
set -e

echo "[+] Deploying GREEN environment"
docker compose -f docker-compose.green.yml up -d --build
