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

# Providers
if [ "$DNS_PROVIDER" = "route53" ]; then

	if aws --version | grep aws-cli/1.; then

		if pip3 uninstall awscli; then true; fi

	fi

	if ! aws --version; then

		curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

		unzip awscliv2.zip

		./aws/install

		rm -fR aws

	fi

	if [ ! -d /root/.aws ]; then

		aws configure

	fi

elif [ "$DNS_PROVIDER" = "godaddy" ]; then

	$INSTALL curl

	# TODO: Create credentials file

fi


source $BASEDIR/auth_check_$DNS_PROVIDER.sh


cat <<EOF


======================================

Initial setup SUCCESSFUL!

======================================

EOF
