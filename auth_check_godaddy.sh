#!/bin/bash

set -e

source /root/.godaddy/credentials

AUTH="Authorization: sso-key $GODADDY_KEY:$GODADDY_SECRET"

echo $AUTH

curl -X GET -H "$AUTH" "https://api.godaddy.com/v1/domains" > /dev/null 2>&1