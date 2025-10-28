#!/bin/bash
count=$(ps -fe |  grep perl | grep -E "(compress|compress_).*pl" | wc -l)
if [ $count -gt 0 ]
then
        echo "Run Of Compress $count -- $(date)";
        exit
else
                echo "Run Compress $(date)";
                /opt/telc/scripts/compress.pl;
fi
