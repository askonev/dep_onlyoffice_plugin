# deployment_onlyoffice-plugins

Bash script for installing or updating current plugin into the document server

## Dependencies

* docker
* standalone docker-compose
* [ifconfig](https://man.cx/ifconfig(1))
* google-chrome

## Getting Started

1. Enter data in the .env file

2. Install the folder with the plugin in the directory
   
   ```bash
    ./asset
   ```

   or use the script

   >Plugin must be contained in the project [sdkjs_plugins](https://github.com/ONLYOFFICE/sdkjs-plugins)

   ```bash
    ./lib/plugin_cloning.sh [PLUGIN NAME]
   ``` 

   Add the name of the plugin of interest as the value of the variable `$PLUGIN_NAME`

3. In the file *./plugin_run* change the value of the variable `$PLUGIN_NAME`

4. To install the plugin and start the document server, use the --ds flag

   ```bash
    ./plugin_run.sh --ds
   ```

5. To update the plugin, run the start.sh script without parameters

   ```bash
    ./plugin_run.sh
   ```
