#!/bin/bash

source lib/stopwatcher.sh

PLUGIN_NAME=paste-html-example

DOCSERVER_DIR_FOR_PLUGINS=/var/www/onlyoffice/documentserver/sdkjs-plugins/plugins
CONTAINER_NAME=3_sdkjsplugins_docserver_1
HOST_IP=http://192.168.0.178:6060

# if "case" = "param" then used corresponding code of block
case "$1" in
-d)
  docker-compose up -d docserver
  stopwatcher 90
  # Start example
  docker exec $CONTAINER_NAME sudo supervisorctl start ds:example
  docker exec $CONTAINER_NAME sudo sed 's,autostart=false,autostart=true,' -i /etc/supervisor/conf.d/ds-example.conf
;;
esac
# Shifts positional parameters to the left
shift

# check .gz files into plugin
ls -1 ./plugins_list/$PLUGIN_NAME/*.gz &> start.log
if [ $? -eq 2 ]; then
    tput setaf 3; echo  "No such file or directory"; printf '\e[m'
else
    for file in $(find ./plugins_list/$PLUGIN_NAME -name '*.gz');
      do
        rm $file;
        tput setaf 2; echo "*.gz deleted"; printf '\e[m'
      done
fi

# Move plugins inside document server
docker-compose exec -w $DOCSERVER_DIR_FOR_PLUGINS docserver cp -r ./$PLUGIN_NAME .. 2>> start.log
if [[ $? -eq 0 ]]
then
  tput setaf 2; echo  "Plugin dir copied"; printf '\e[m'
else
  tput setaf 1; echo  "Docker container doesn't exist."; printf '\e[m'
  exit 1
fi

# update with new plugin
docker-compose restart docserver
# docker-compose exec docserver supervisorctl restart all
# docker-compose exec docserver supervisorctl restart ds:docservice

stopwatcher 70
tput setaf 2; echo "Plugin exist: true"; printf '\e[m' # colorize log green

google-chrome --incognito --new-window $HOST_IP/example/
