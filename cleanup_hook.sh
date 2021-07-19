#!/bin/bash

set -e

if [ -z "$CERTBOT_DOMAIN" ]; then exit 1; fi

BASEDIR=$(dirname "$0")

source $BASEDIR/certbot.vars.sh

rm temp_record.json
