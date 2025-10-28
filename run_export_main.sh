#!/bin/bash
count=$(ps -fe |  grep perl | grep -e "main_export.pl" | wc -l)
if [ $count -gt 0 ]
then
        echo "Run Of export main  $count -- $(date)";
        exit
else
                echo "Run Compress $(date)";
                /opt/telc/scripts/main_export.pl;
fi
