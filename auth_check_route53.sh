#!/bin/bash

set -e

if ! aws sts get-caller-identity > /dev/null 2>&1; then

	echo "No permissions for AWS CLI"

	exit 1

fi

aws iam get-account-authorization-details > auth_details.json

if ! cat auth_details.json | grep route53:ListHostedZones > /dev/null 2>&1; then

	echo "Insufficient permissions for route53:ListHostedZones"

	echo "Fix IAM permissions and run setup.sh"

	exit 1

fi

if ! cat auth_details.json | grep route53:ChangeResourceRecordSets > /dev/null 2>&1; then

	echo "Insufficient permissions for route53:ChangeResourceRecordSets"

	echo "Fix IAM permissions and run setup.sh"

	exit 1

fi