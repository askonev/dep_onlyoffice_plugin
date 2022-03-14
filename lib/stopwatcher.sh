#!/bin/bash

function stopwatcher() {
  i=0
  end=$(( $1 * 10 ))

  now=$(date +%s)sec
  while [ $i -le $end ]
   do
       printf "%s\r" $(TZ=UTC date --date now-$now +%H:%M:%S.%N)
       sleep 0.1
       i=$(( i + 1 ))
  done
}
