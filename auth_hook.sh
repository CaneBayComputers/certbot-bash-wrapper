#!/bin/bash

set -e

if [ -z "$CERTBOT_DOMAIN" ]; then exit 1; fi

BASEDIR=$(dirname "$0")

source $BASEDIR/certbot.vars.sh

if [ -z "$TTL" ]; then TTL=300; fi

echo $CERTBOT_DOMAIN

echo $CERTBOT_VALIDATION

ZONE=$(sed 's/.*\.\(.*\..*\)/\1/' <<< $CERTBOT_DOMAIN)

if [ -z "$ZONE" ]; then exit 1; fi

echo $ZONE

HOST_ID=`aws route53 list-hosted-zones --output text | grep $ZONE. | cut -d $'\t' -f 3`

if [ -z "$HOST_ID" ]; then exit 1; fi

echo $HOST_ID

cat > temp_record.json <<EOT
{
    "Comment": "UPSERT a record",
    "Changes": [
        {
            "Action": "UPSERT",
            "ResourceRecordSet": {
                "Name": "_acme-challenge.$CERTBOT_DOMAIN",
                "Type": "TXT",
                "TTL": $TTL,
                "ResourceRecords": [{ "Value": "\"$CERTBOT_VALIDATION\""}]
            }
        }
    ]
}
EOT

cat temp_record.json

aws route53 change-resource-record-sets --hosted-zone-id $HOST_ID --change-batch file://temp_record.json

rm temp_record.json

if [ -z "$WAIT" ]; then WAIT=30; fi

echo "Sleeping $WAIT seconds ..."

sleep $WAIT