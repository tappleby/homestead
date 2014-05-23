#!/usr/bin/env bash

HOMESTEAD_DIR="/.homestead"
WATCH_PATH="$HOMESTEAD_DIR/watch-$1.sh"

watcher="#!/usr/bin/env bash
$2
"

block="# Homestead Watch Service
description \"Homestead Watcher - $1\"
author \"Homestead\"
start on vagrant-mounted
exec $WATCH_PATH > /tmp/watch-$1.log 2>&1
respawn
respawn limit 15 5
"

[ -d $HOMESTEAD_DIR ] || mkdir $HOMESTEAD_DIR

echo "$watcher" > $WATCH_PATH
chmod +x $WATCH_PATH

echo "$block" > "/etc/init/watch-$1.conf"
service watch-$1 restart