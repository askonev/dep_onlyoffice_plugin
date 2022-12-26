#!/bin/bash

function stopwatcher() {
  i=0
  end=$(( $1 * 10 ))

  now=$(date +%s)sec
  while [ $i -le $end ]
   do
       # shellcheck disable=SC2046
       printf "%s\r" $(TZ=UTC date --date now-"$now" +_stopwatcher_%M:%S.%N)
       sleep 0.1
       i=$(( i + 1 ))
  done
}
