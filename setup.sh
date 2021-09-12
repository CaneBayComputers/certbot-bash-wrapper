#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

BASEDIR=$(dirname "$0")

source $BASEDIR/certbot.vars.sh

# Get pkg manager
if [ -z "$INSTALL" ]; then
	if [ -x "$(command -v apk)" ];       then INSTALL='apk add --no-cache'
	elif [ -x "$(command -v apt-get)" ]; then INSTALL='apt-get -y install'
	elif [ -x "$(command -v dnf)" ];     then INSTALL='dnf -y install'
	elif [ -x "$(command -v zypper)" ];  then INSTALL='zypper -n install'
	elif [ -x "$(command -v pacman)" ];  then INSTALL='pacman --noconfirm -S'
	fi
fi

# Remove bullcrap certbot installed by snap
if snap remove certbot > /dev/null 2>&1; then true; fi

# Install package maintained certbot
if $INSTALL certbot > /dev/null 2>&1; then true; fi




if [ "$DNS_PROVIDER" = "route53" ]; then

	# Install AWS client
	if ! aws --version > /dev/null 2>&1; then

		curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"

		unzip awscli-bundle.zip

		rm -f awscli-bundle.zip

		if $INSTALL python3-venv; then true; fi

		python3 awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

		rm -fR awscli-bundle

	fi

	if [ ! -d /root/.aws ]; then

		aws configure

	fi





elif [ "$DNS_PROVIDER" = "godaddy" ]; then

	$INSTALL curl




fi


source $BASEDIR/auth_check_$DNS_PROVIDER.sh


cat <<EOF


======================================

Initial setup SUCCESSFUL!

======================================

EOF
