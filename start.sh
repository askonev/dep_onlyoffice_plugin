#!/bin/bash

source lib/stopwatcher.sh
source lib/plugin_starter_helper.sh

PLUGIN_NAME=

DOCSERVER_DIR_FOR_PLUGINS=/var/www/onlyoffice/documentserver/sdkjs-plugins/plugins
HOST_IP=$(get_host_ip)

# if "case" = "param" then used corresponding code of block
case "$1" in
-d)
  docker-compose up -d docserver
  stopwatcher 90
  start_document_server_example
;;
esac
# Shifts positional parameters to the left
shift

# check .gz files in plugin
ls ./plugins_list/$PLUGIN_NAME/*.gz &> /dev/null
remove_gz_in_dir $?

# Move plugins inside document server
docker-compose exec -w $DOCSERVER_DIR_FOR_PLUGINS docserver cp -r ./$PLUGIN_NAME .. 2>> err.log
check_for_successful_copying $?

# For new plugin need restart docserver
docker-compose restart docserver

stopwatcher 70
tput setaf 2; echo "Plugin exist: true"; printf '\e[m' # colorize log green

google-chrome --incognito --new-window http://$HOST_IP:6060/example/
