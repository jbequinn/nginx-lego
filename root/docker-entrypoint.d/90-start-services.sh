#!/bin/sh

echo "- Starting other services"

echo "  * Starting Cron"
crond -l 2 -f &
