#!/bin/bash
#source ./start.sh

PATH_TO_DOCEXAMPLE_CONFIG=/etc/onlyoffice/documentserver-example
URL_PLUGINBASE=https://raw.githubusercontent.com/ONLYOFFICE/sdkjs-plugins/feature/desktop_build/pluginBase.js

PLUGIN_NAME=add-textbaustein-plugin
CONTAINER_NAME=3_sdkjsplugins_docserver_1

#docker-compose up -d nginx
# Add pluginBase.js
#curl $URL_PLUGINBASE -o ./$PLUGIN_NAME/pluginBase.js

docker exec $CONTAINER_NAME \
  mv $PATH_TO_DOCEXAMPLE_CONFIG/local.json $PATH_TO_DOCEXAMPLE_CONFIG/local.json.backup
docker cp ./local.json $CONTAINER_NAME:$PATH_TO_DOCEXAMPLE_CONFIG/

docker exec $CONTAINER_NAME chown root:root $PATH_TO_DOCEXAMPLE_CONFIG/local.json
docker exec $CONTAINER_NAME chmod 644 $PATH_TO_DOCEXAMPLE_CONFIG/local.json
#sed -i '3s,"","'$S3_PRIVATE_KEY'",' Dockerfile

# google-chrome http://192.168.0.178:6061/$PLUGIN_NAME/pluginBase.js