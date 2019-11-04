#!/bin/sh

if [ -z "${DOCKER_DIR}" ]; then
  DOCKER_DIR="$(cd "$(dirname "$0")"/../docker||exit;pwd)"
fi
echo "DOCKER_DIR=${DOCKER_DIR}"

cd "${DOCKER_DIR}" || exit

CURRENT_UID=$(id -u):$(id -g) docker-compose down

