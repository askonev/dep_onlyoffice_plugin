#!/bin/bash

PLUGIN_PATH=helloworld/scripts/helloworld.js

docker exec starter_sdkjsplugins_docserver_1 \
      cat /var/www/onlyoffice/documentserver/sdkjs-plugins/plugins/$PLUGIN_PATH
