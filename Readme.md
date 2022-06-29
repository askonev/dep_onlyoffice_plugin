# deployment_onlyoffice-plugins

Bash script for installing and updating the plugin into the document server

## Dependencies

* docker
* Standalone docker compose
* ifconfig
* google-chrome browser

## Getting Started

1. Enter data in the .env file

2. Install the folder with the plugin in the directory

    `./plugins_list`

   or use the script 
 
    `lib/cloning_plugin.sh`

   Add the name of the plugin of interest as the value of the variable `$PLUGIN_NAME`

3. In the file ./start.sh change the value of the variable `$PLUGIN_NAME`

4. To install the plugin and start the document server, use the --docker flag

    `./start --docker`

5. To update the plugin, run the start.sh script without parameters

    `start.sh`