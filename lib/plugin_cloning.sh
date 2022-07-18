#!/bin/bash

PLUGIN_NAME="helloworld"
ASSERT_FOLDER="../asset" #

function cloning_plugin {

PLUGIN_NAME=$1
DS_PLUGINS_DIR=$2

REMOTE_REPO="sdkjs-plugins"
TMP_PLUGINS_DIR=/tmp/$REMOTE_REPO

git clone -b master --depth 1 https://github.com/ONLYOFFICE/"$REMOTE_REPO"/ "$TMP_PLUGINS_DIR"

cp -r --verbose "$TMP_PLUGINS_DIR"/"$PLUGIN_NAME" "$DS_PLUGINS_DIR"

rm -rf "$TMP_PLUGINS_DIR"

}

cloning_plugin "$PLUGIN_NAME" "$ASSERT_FOLDER"
