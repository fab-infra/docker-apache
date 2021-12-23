#!/bin/sh -ex

# Set default environment
export SERVER_NAME="${SERVER_NAME:-$(hostname -f)}"
export SERVER_ENV="${SERVER_ENV:-production}"
export DEFAULT_DOCROOT="${DEFAULT_DOCROOT:-/srv/www/htdocs}"
export LISTEN_HTTP_PORT="${LISTEN_HTTP_PORT:-8080}"
export LISTEN_HTTPS_PORT="${LISTEN_HTTPS_PORT:-8443}"

# Generate configuration
confd -onetime -backend env

# Start Apache
exec start_apache2 -DFOREGROUND
