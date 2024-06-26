#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

BASEDIR=$(dirname "$0")

source $BASEDIR/certbot.vars.sh

source $BASEDIR/auth_check_$DNS_PROVIDER.sh

if [ ! -z "$PRE_CMD" ]; then $PRE_CMD; fi

if [ -z "$DEBUG" ]; then DEBUG=false; fi

if $DEBUG; then DEBUG='-v --dry-run --test-cert'; else DEBUG=''; fi

if [ -z "$FORCE" ]; then FORCE=false; fi

if $FORCE; then FORCE='--force-renewal'; else FORCE=''; fi

# https://certbot.eff.org/docs/using.html
certbot -n $DEBUG $FORCE --agree-tos --email $EMAIL --no-eff-email --manual \
	--manual-auth-hook $BASEDIR/auth_hook_$DNS_PROVIDER.sh --preferred-challenges dns \
  --cert-name $NAME --expand -d $DOMAINS certonly

if [ ! -z "$POST_CMD" ]; then $POST_CMD; fi
