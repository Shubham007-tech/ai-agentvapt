#!/bin/bash
set -e

IMAGE_NAME="agent-mgmt-app"
CONTAINER_NAME="agent-mgmt-app"
PORT=3000

# ── 1. Build Docker image ──────────────────────────────────────────────────────
echo "[deploy] Building image: $IMAGE_NAME"
docker build -t "$IMAGE_NAME" .

# ── 2. Remove old container if it exists ──────────────────────────────────────
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[deploy] Removing old container: $CONTAINER_NAME"
  docker rm -f "$CONTAINER_NAME"
fi

# ── 3. Start new container with runtime env vars ───────────────────────────────
echo "[deploy] Starting container: $CONTAINER_NAME on port $PORT"
docker run -d \
  --name "$CONTAINER_NAME" \
  -p "$PORT:80" \
  -e API_BASE_URL="http://localhost:8000" \
  -e APP_ENV="production" \
  "$IMAGE_NAME"

echo "[deploy] Done. App running at http://localhost:$PORT/vapt_iaura_services/"
