#!/bin/bash

PLUGIN_NAME=$1
ASSET_DIR="$(pwd)/asset"

echo $PLUGIN_NAME
echo $ASSET_DIR

function cloning_plugin
{
PLUGIN_NAME=$1
ASSET_DIR=$2

REMOTE_REPO="sdkjs-plugins"
TMP_PLUGINS_DIR=/tmp/$REMOTE_REPO

git clone -b master --depth 1 https://github.com/ONLYOFFICE/"$REMOTE_REPO"/ "$TMP_PLUGINS_DIR"
cp -r --verbose "$TMP_PLUGINS_DIR"/"$PLUGIN_NAME" "$ASSET_DIR"
rm -rf "$TMP_PLUGINS_DIR"
}

cloning_plugin "$PLUGIN_NAME" "$ASSET_DIR"
