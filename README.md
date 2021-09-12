# Letsencrypt Certbot for Route53 And GoDaddy: Easy Setup

## Installation and Setup Instructions

First, copy the example file and edit as needed:

`sudo cp certbot.vars.example.sh certbot.vars.sh`

Next, run the one-time setup script:

`sudo ./setup.sh`

It will show you the SSL config you need to enter into your web server.

Finally, run the Certbot setup script:

`sudo ./certbot.sh`