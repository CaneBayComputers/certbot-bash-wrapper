#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

BASEDIR=$(dirname "$0")

source $BASEDIR/certbot.vars.sh

source $BASEDIR/auth_check.sh

if [ ! -z "$PRE_CMD" ]; then $PRE_CMD; fi

if [ -z "$DEBUG" ]; then DEBUG=false; fi

if $DEBUG; then DEBUG='-v --dry-run --test-cert'; else DEBUG=''; fi

# https://certbot.eff.org/docs/using.html
certbot -n $DEBUG --agree-tos --email $EMAIL --no-eff-email --manual-public-ip-logging-ok --manual \
	--manual-auth-hook $BASEDIR/auth_hook.sh --preferred-challenges dns --cert-name $NAME --expand -d $DOMAINS certonly

if [ ! -z "$POST_CMD" ]; then $POST_CMD; fi