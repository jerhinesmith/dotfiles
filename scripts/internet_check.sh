#!/bin/bash

INTERNET_STATUS="UNKNOWN"
NETWORK_NAME="UNKNOWN"
TIMESTAMP=`date +%s`
while [ 1 ]
 do
    NETWORK_NAME=`/Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | awk -F:  '($1 ~ "^ *SSID$"){print $2}' | cut -c 2-` 

    if [ "$NETWORK_NAME" = "The Jim’s Gym" ]; then
      ping -c 1 -W 0.7 8.8.4.4 > /dev/null 2>&1
      if [ $? -eq 0 ] ; then
          if [ "$INTERNET_STATUS" != "UP" ]; then
              echo -e "\033[1;32mUP\033[0m   `date +%Y-%m-%dT%H:%M:%S%Z` $((`date +%s`-$TIMESTAMP))";
              # echo "UP   `date +%Y-%m-%dT%H:%M:%S%Z` $((`date +%s`-$TIMESTAMP))";
              INTERNET_STATUS="UP"
          fi
      else
          if [ "$INTERNET_STATUS" = "UP" ]; then
              echo -e "\033[1;31mDOWN\033[0m `date +%Y-%m-%dT%H:%M:%S%Z` $((`date +%s`-$TIMESTAMP))";
              # echo "DOWN `date +%Y-%m-%dT%H:%M:%S%Z` $((`date +%s`-$TIMESTAMP))";
              INTERNET_STATUS="DOWN"
          fi
      fi
    fi
    sleep 1
 done;

