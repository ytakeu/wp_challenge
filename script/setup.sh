#!/bin/sh

if [ -z "${DOCKER_DIR}" ]; then
  DOCKER_DIR="$(cd "$(dirname "$0")"/../docker||exit;pwd)"
fi
echo "DOCKER_DIR=${DOCKER_DIR}"

cd "${DOCKER_DIR}" || exit


if [ ! -e "${DOCKER_DIR}"/var/www/html ]; then
  mkdir -p "${DOCKER_DIR}"/var/www/html
fi
if [ ! -e "${DOCKER_DIR}"/etc/apache2/sites-available/000-default.conf ]; then
  cp "${DOCKER_DIR}"/etc/apache2/sites-available/000-default.sample.conf \
     "${DOCKER_DIR}"/etc/apache2/sites-available/000-default.conf
fi

if [ ! -e "${DOCKER_DIR}"/etc/apache2/ports.conf ]; then
  cp "${DOCKER_DIR}"/etc/apache2/ports.sample.conf \
     "${DOCKER_DIR}"/etc/apache2/ports.conf
fi

CURRENT_UID=$(id -u):$(id -g) docker-compose up

