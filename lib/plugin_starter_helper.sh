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