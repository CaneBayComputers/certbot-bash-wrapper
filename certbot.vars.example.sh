# Copy this file, set the variables and rename to: certbot.vars.sh

# REQUIRED

# Email used for registration and recovery contact. Use comma to
# register multiple emails
EMAIL=me@example.com

# The name is arbitrary. It just sets the folder name for the cert.
# It does not have to match the domain name in any way. Per docs:
# Certificate name to apply. This name is used by Certbot for
# housekeeping and in file paths; it doesn't affect the content of
# the certificate itself. NO SPACES OR SPECIAL CHARACTERS!
NAME=whatevername

# Seperate domains and subdomains with commas.
DOMAINS=domain.com,www.domain.com,*.domain.com

# OPTIONAL

# Explicitly sets the command for installing system packages.
# Default is blank (Auto detect).
#INSTALL="apt-get -y install"

# Sets the Time to Live for the DNS record. Default is 300.
#TTL=300

# Sleep for specific amount of seconds before pulling new DNS
# record, ie. wait for propagation. Default is 30.
#WAIT=30

# Command to run before cert install. This is a good place to
# stop your webserver. Default is blank (Run nothing).
#PRE_CMD="service nginx stop"
#PRE_CMD="pre_script.sh"

# Command to run after cert install. This is a good place to
# restart your webserver. Default is blank (Run nothing).
#POST_CMD="service nginx start"
#POST_CMD="post_script.sh"

# Produces some output along with a dry-run that will not
# create or renew certs but will get a cert from a staging
# server. Default is false.
#DEBUG=true

# Force renewals. Default is false.
#FORCE=true