#!/bin/bash

function remove_gz_in_dir {

  if [ $? -eq 2 ]; then
      tput setaf 3; echo  "*.gz deleted"; printf '\e[m'
  else
      # shellcheck disable=SC2044
      for file in $(find ./asset/"$PLUGIN_NAME" -name '*.gz');
        do
          rm "$file"
        done
      tput setaf 2; echo "*.gz deleted"; printf '\e[m'
  fi

}

function start_document_server_example {

    docker-compose exec docserver sudo supervisorctl start ds:example
    docker-compose exec docserver sudo sed 's,autostart=false,autostart=true,' -i /etc/supervisor/conf.d/ds-example.conf

}

function success_check {

  # shellcheck disable=SC2181
  if [[ $? -eq 0 ]]
  then
    tput setaf 2; echo  "$1"; printf '\e[m' # green colorized
  else
    tput setaf 1; echo  "Execution error. Exit 1"; printf '\e[m' # red colorized
    exit 1
  fi

}

function get_host_ip {

  ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | \
        grep -Eo '([0-9]*\.){3}[0-9]*' | \
        grep -v '127.0.0.1' | \
        grep -Eo '192.([0-9]*\.){2}([0-9]{3,})'

}
