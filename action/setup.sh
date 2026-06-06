#!/usr/bin/env bash
set -euo pipefail

echo "=== Terminal Container Setup ==="
echo "Session ID: ${SESSION_ID}"
echo "Backend URL: ${BACKEND_URL}"

mkdir -p /tmp/codew-containers

check_deps() {
  local deps=("docker" "node" "npm")
  for dep in "${deps[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
      echo "ERROR: Required dependency '$dep' is not installed."
      exit 1
    fi
  done
  echo "All dependencies are installed."
}

check_docker_running() {
  if ! docker info &>/dev/null; then
    echo "ERROR: Docker daemon is not running."
    exit 1
  fi
  echo "Docker daemon is running."
}

ensure_network() {
  if ! docker network ls --format '{{.Name}}' | grep -q '^codew-terminal$'; then
    docker network create codew-terminal 2>/dev/null || true
    echo "Created Docker network: codew-terminal"
  else
    echo "Docker network codew-terminal already exists"
  fi
}

cleanup_stale() {
  docker rm -f "terminal-${SESSION_ID}" 2>/dev/null || true
}

check_deps
check_docker_running
ensure_network
cleanup_stale

echo "=== Setup Complete ==="
