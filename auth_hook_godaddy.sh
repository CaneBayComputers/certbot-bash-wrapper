#!/bin/bash

set -e

if [ -z "$CERTBOT_DOMAIN" ]; then exit 1; fi

BASEDIR=$(dirname "$0")

source $BASEDIR/certbot.vars.sh

source /root/.godaddy/credentials

AUTH="Authorization: sso-key $GODADDY_KEY:$GODADDY_SECRET"

if [ $TTL -lt 600 ]; then TTL=600; fi

echo "Certbot Domain: $CERTBOT_DOMAIN"

echo "Certbot Validation: $CERTBOT_VALIDATION"

ZONE=$(sed 's/.*\.\(.*\..*\)/\1/' <<< $CERTBOT_DOMAIN)

if [ -z "$ZONE" ]; then exit 1; fi

echo "Zone: $ZONE"

SUBDOMAIN=$(sed "s/$ZONE//" <<< $CERTBOT_DOMAIN)

if [ ! -z "$SUBDOMAIN" ]; then SUBDOMAIN=".${SUBDOMAIN::-1}"; fi

NAME="_acme-challenge$SUBDOMAIN"

echo "Name: $NAME"

ENDPOINT="https://api.godaddy.com/v1/domains/$ZONE/records"

if curl -X DELETE -H "$AUTH" "$ENDPOINT/TXT/$NAME" > /dev/null 2>&1; then sleep $WAIT; fi

cat > temp_record.json <<EOT
[
	{
	    "data": "$CERTBOT_VALIDATION",
	    "name": "$NAME",
	    "ttl": $TTL,
	    "type": "TXT"
	}
]
EOT

if curl -X PATCH -H "$AUTH" -H "Content-Type: application/json" -d @temp_record.json "$ENDPOINT" > /dev/null 2>&1; then true; fi

rm temp_record.json

sleep $WAIT