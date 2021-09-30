#!/bin/bash

function remove_gz_in_dir {

  if [ $? -eq 2 ]; then
      tput setaf 3; echo  "*.gz deleted"; printf '\e[m'
  else
      for file in $(find ./plugins_list/$PLUGIN_NAME -name '*.gz');
        do
          rm $file
        done
      tput setaf 2; echo "*.gz deleted"; printf '\e[m'
  fi

}

function start_document_server_example {

    docker-compose exec docserver sudo supervisorctl start ds:example
    docker-compose exec docserver sudo sed 's,autostart=false,autostart=true,' -i /etc/supervisor/conf.d/ds-example.conf

}

function check_for_successful_copying {

  if [[ $? -eq 0 ]]
  then
    tput setaf 2; echo  "Plugin dir copied"; printf '\e[m'
  else
    tput setaf 1; echo  "Docker container doesn't exist."; printf '\e[m'
    exit 1
  fi

}
