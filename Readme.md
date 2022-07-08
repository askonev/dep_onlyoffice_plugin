# deployment_onlyoffice-plugins

Bash script for installing and updating the plugin into the document server

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

   ```bash
    lib/cloning_plugin.sh
   ```

   Add the name of the plugin of interest as the value of the variable `$PLUGIN_NAME`

3. In the file *./plugin_run.sh* change the value of the variable `$PLUGIN_NAME`

4. To install the plugin and start the document server, use the --docker flag

   ```bash
   ./plugin_run.sh --docker
   ```

5. To update the plugin, run the start.sh script without parameters

   ```bash
     ./plugin_run.sh
   ```
