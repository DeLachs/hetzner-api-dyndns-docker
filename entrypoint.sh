#!/bin/bash

# copy the env vars for cron
printenv > /etc/environment

# run the script for the first time
/dyndns.sh

# execute cron in the foreground
cron -f