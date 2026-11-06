#!/usr/bin/env bash
# Health check — used by Docker healthcheck + CI after deploy
set -e
URL="${HEALTH_URL:-http://localhost:3000/health}"
echo "Checking $URL ..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || echo "000")
if [ "$HTTP_CODE" = "200" ]; then
  echo "OK — $HTTP_CODE"
  exit 0
else
  echo "FAIL — $HTTP_CODE"
  exit 1
fi
