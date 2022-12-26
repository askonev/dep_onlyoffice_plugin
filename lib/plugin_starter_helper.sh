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

function _grep_ip {
# Searches ip over network 192.*.*.*
HOST_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | \
          grep -Eo '([0-9]*\.){3}[0-9]*' | \
          grep -v '127.0.0.1' | \
          grep -Eo '192.([0-9]*\.){2}([0-9]{2,3})')
if [ $HOST_IP ]
then
  tput setaf 2; echo  "IP $HOST_IP grepped"; printf '\e[m' # green colorized
else
  # Searches ip from the network 172.*.*.* and by wlp3s0
  HOST_IP=$(ifconfig | grep -A 1 wlp3s0 | \
                      grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | \
                      grep -Eo '172.([0-9]*\.){2}([0-9]{1,3})')
  if [ $HOST_IP ]
  then
    tput setaf 2; echo  "IP $HOST_IP grepped"; printf '\e[m' # green colorized
  else
    tput setaf 1; echo  "Error searching for IP. Exit 1"; printf '\e[m' # red colorized
    exit 1
  fi
fi
}

function _log_cleaner {
  LOG_FOLDER="$(pwd)/documentserver_log"
  sudo rm -r $LOG_FOLDER/data \
             $LOG_FOLDER/db \
             $LOG_FOLDER/lib \
             $LOG_FOLDER/logs
}
