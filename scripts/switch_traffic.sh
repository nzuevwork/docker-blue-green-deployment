#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"
if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: $0 {blue|green}"
  exit 1
fi

BACKEND="app-${TARGET}"

# Определяем имя nginx сервиса в compose
SERVICE="nginx"
if ! docker compose ps --services | grep -qx "$SERVICE"; then
  SERVICE="nginx-proxy"
fi

echo "Switching to: ${BACKEND} (service: ${SERVICE})"

# Пересоздаём nginx с нужным BACKEND
BACKEND="${BACKEND}" docker compose up -d --force-recreate "$SERVICE"

# Smoke test: ждём пока nginx поднимется после recreate
for i in {1..20}; do
  if curl -fsS http://localhost/ >/dev/null; then
    echo "smoke: ok"
    break
  fi
  echo "smoke: retry $i/20..."
  sleep 1
done

# если так и не поднялось — фейлим деплой
curl -fsS http://localhost/ >/dev/null

# Доп. health (не фейлим деплой, если эндпоинта нет)
curl -fsS http://localhost/__health >/dev/null 2>&1 && echo "health: ok" || echo "health: skip"

# Сохраняем активное окружение ТОЛЬКО после успеха
echo "BACKEND=${BACKEND}" > .env

# Логи для Actions
docker compose ps
curl -fsS http://localhost/ | grep -E 'BLUE|GREEN' -n || true
