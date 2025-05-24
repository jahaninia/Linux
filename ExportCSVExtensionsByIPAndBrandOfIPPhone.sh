#!/bin/bash

echo "Extension,IP Address,Useragent"

for i in $(asterisk -rx "sip show peers" | awk 'NF && $1 ~ /^[0-9]+\/[0-9]+/ {print $1}' | cut -d'/' -f1); do
    info=$(asterisk -rx "sip show peer $i")
    ip=$(echo "$info" | grep "Addr->IP" | awk '{print $3}' | cut -d: -f1)
    ua=$(echo "$info" | grep -i "Useragent" | cut -d ':' -f2- | sed 's/,/ /g' | xargs)
    echo "$i,$ip,$ua"
done

