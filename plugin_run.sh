#!/bin/bash

source .env
source lib/stopwatcher.sh
source lib/plugin_starter_helper.sh


PLUGIN_NAME=helloworld


# Static data
DS_PLUGINS_DIR=/var/www/onlyoffice/documentserver/sdkjs-plugins/

# Dynamic data
_grep_ip

# if "case" = "param" then used corresponding code of block
case "$1" in
--ds)
  _remove_logs $LOGS_DIR
  # start with onlyoffice docker
  docker compose up -d docserver
  stopwatcher 80
  start_document_server_example
;;
esac
# Shifts positional parameters to the left
shift

# check .gz files in plugin
# отошли от схемы с кешированием в
# TODO: но после перезагрузки все равно кеширует
# ls ./assets/$PLUGIN_NAME/*.gz &> /dev/null
# remove_gz_in_dir

docker-compose exec -T docserver ls $DS_PLUGINS_DIR
# remove plugin folder if exist
docker-compose exec -T docserver rm -r $DS_PLUGINS_DIR$PLUGIN_NAME

# Copy plugins inside document server
docker cp ./assets/$PLUGIN_NAME "$(docker-compose ps -q docserver)":$DS_PLUGINS_DIR
success_check "Copying successfully"

# Update docserver services
# docker-compose exec -T docserver supervisorctl restart all
# TODO: необходимо при первой загрузке плагина (выяснить)
docker-compose exec -T docserver supervisorctl restart ds:docservice
docker-compose exec -T docserver service nginx restart
success_check "Plugin installed"

google-chrome --incognito \
              --new-window \
              --auto-open-devtools-for-tabs \
              http://"$HOST_IP":6060/example/ &> /dev/null
