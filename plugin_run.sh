#!/bin/bash

source lib/stopwatcher.sh
source lib/plugin_starter_helper.sh

PLUGIN_NAME=helloworld

DOCSERVER_DIR_FOR_PLUGINS=/var/www/onlyoffice/documentserver/sdkjs-plugins/
HOST_IP=$(get_host_ip)

# if "case" = "param" then used corresponding code of block
case "$1" in
--docker)
  # start with onlyoffice docker
  docker-compose up -d docserver
  stopwatcher 120
  start_document_server_example
;;
esac
# Shifts positional parameters to the left
shift

# check .gz files in plugin
ls ./asset/$PLUGIN_NAME/*.gz &> /dev/null
remove_gz_in_dir

# Copy plugins inside document server
docker cp ./asset/$PLUGIN_NAME "$(docker-compose ps -q docserver)":$DOCSERVER_DIR_FOR_PLUGINS
success_check "Copying successfully"

# Update docserver services
docker-compose exec -T docserver supervisorctl restart all && \
docker-compose exec -T docserver service nginx restart
success_check "Plugin installed"

google-chrome --incognito --new-window http://"$HOST_IP":6060/example/ &> /dev/null
