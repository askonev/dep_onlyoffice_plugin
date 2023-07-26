#!/bin/bash

function remove_gz_in_dir() {
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

function success_check() {
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
HOST_IP=$(ifconfig | grep -A2 tun0 | grep -oP '(?<=inet )([0-9]*\.){3}[0-9]*' \
      || ifconfig | grep -A2 wlp3s0 | grep -oP '(?<=inet )([0-9]*\.){3}[0-9]*')
if [ $HOST_IP ]
then
  tput setaf 2; echo  "IP $HOST_IP grepped"; printf '\e[m' # green colorized
else # Searches ip from the network 172.*.*.*
  HOST_IP=$(ifconfig | grep -A2 enp2s0 | grep -oP '(?<=inet )172.([0-9]*\.){2}([0-9]{1,3})' \
                  || ifconfig | grep -A2 wlp3s0 | grep -oP '(?<=inet )172.([0-9]*\.){2}([0-9]{1,3})')
  if [ $HOST_IP ]
  then
    tput setaf 2; echo  "ip: $HOST_IP"; printf '\e[m' # green colorized
  else
    tput setaf 1; echo  "Error searching for ip address. Exit 1"; printf '\e[m' # red colorized
    exit 1
  fi
fi
}

function _remove_logs() {
  echo "logs dir: $1"
  sudo rm -r $1/*
  shift
}
