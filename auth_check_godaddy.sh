#!/bin/bash

set -e

source /root/.godaddy/credentials

AUTH="Authorization: sso-key $GODADDY_KEY:$GODADDY_SECRET"

echo $AUTH

RESPONSE=$(curl -s -X GET -H "$AUTH" "https://api.godaddy.com/v1/domains")

if echo $RESPONSE | grep "ACCESS_DENIED"; then exit 1; fi