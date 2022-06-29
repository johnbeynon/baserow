#!/bin/bash

set -euo pipefail

export BASEROW_PUBLIC_URL=$RENDER_EXTERNAL_URL
export BASEROW_CADDY_ADDRESSES=":$PORT"
export REDIS_URL=${REDIS_TLS_URL:-$REDIS_URL}
export DJANGO_SETTINGS_MODULE='baserow.config.settings.heroku'
export BASEROW_RUN_MINIMAL=yes
export DISABLE_EMBEDDED_PSQL=yes
export DISABLE_EMBEDDED_REDIS=yes
export SYNC_TEMPLATES_ON_STARTUP="${SYNC_TEMPLATES_ON_STARTUP:-false}"
export BASEROW_TRIGGER_SYNC_TEMPLATES_AFTER_MIGRATION=${BASEROW_TRIGGER_SYNC_TEMPLATES_AFTER_MIGRATION:-$SYNC_TEMPLATES_ON_STARTUP}
export MIGRATE_ON_STARTUP="${MIGRATE_ON_STARTUP:-false}"
# Heroku does not support mounting volumes!
export DISABLE_VOLUME_CHECK=yes

export BASEROW_AMOUNT_OF_WORKERS=${BASEROW_AMOUNT_OF_WORKERS:-1}
export BASEROW_AMOUNT_OF_GUNICORN_WORKERS=${BASEROW_AMOUNT_OF_GUNICORN_WORKERS:-$BASEROW_AMOUNT_OF_WORKERS}

export EMAIL_SMTP="false"
# export EMAIL_SMTP_USE_TLS=""
# export FROM_EMAIL="no-reply@$MAILGUN_DOMAIN"

# export EMAIL_SMTP_HOST=$MAILGUN_SMTP_SERVER
# export EMAIL_SMTP_PORT=$MAILGUN_SMTP_PORT
# export EMAIL_SMTP_USER=$MAILGUN_SMTP_LOGIN
# export EMAIL_SMTP_PASSWORD=$MAILGUN_SMTP_PASSWORD
# Heroku generates a random user who runs this container, set DOCKER_USER to that user
# so we can setup the DATA_DIR.
DOCKER_USER=$(whoami)
export DOCKER_USER