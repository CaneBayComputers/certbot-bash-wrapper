# Letsencrypt Certbot and Route53 Automatic DNS: Easy Setup

The purpose of this project is to offer a very easy setup of using Certbot and automatically updating Route53 DNS records. This can be used as a one-time setup installation and for renewals. The main script can also be used in crontab to auto renew certs instead of `certbot renew`. There are no need of Certbot plugins. At the time of this writing, in order to install and utilize the Route53 Certbot plugin, or any plugin for that matter, requires the newest Certbot version which, I believe, can only be obtained via a Snap package. Trying to get the Python plugin packages to work with everything is often fraught with errors. This AWS Route53 Certbot DNS automatic record script uses all bash except for one Python command to install AWS CLI (Command Line Interface). The setup script will both install certbot, via auto-detected package manager, and the latest AWS CLI. You just need to make sure the credentials you enter have access to UPSERT Route53 DNS records and read the hosted zones.

## Installation and Setup Instructions

First, copy the example file and edit as needed:

`sudo cp certbot.vars.example.sh certbot.vars.sh`

Next, run the one-time setup script:

`sudo ./setup.sh`

It will show you the SSL config you need to enter into your web server.

Finally, run the Certbot setup script:

`sudo ./certbot.sh`