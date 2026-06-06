#!/usr/bin/env bash
set -euo pipefail

if [ -z "${SESSION_ID:-}" ]; then
  echo "ERROR: SESSION_ID environment variable is required"
  exit 1
fi

if [ -z "${BACKEND_URL:-}" ]; then
  echo "ERROR: BACKEND_URL environment variable is required"
  exit 1
fi

echo "Starting Codew Terminal Agent"
echo "  Session ID: ${SESSION_ID}"
echo "  Backend URL: ${BACKEND_URL}"

cd /opt/codew-agent
exec node agent.js
