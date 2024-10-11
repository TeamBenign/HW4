#!/bin/bash

grep 'sample' file* | cut -d: -f1 | xargs grep -o 'CSC510' | uniq -c | grep -E '^\s*[3-9]|^\s*[1-9][0-9]' | sed 's/:CSC510//' | gawk '{print $1,$2}' | xargs -I {} sh -c 'set -- {}; ls -l $2 | gawk -v count=$1 "{print count, \$5, \$9}"' | sort -k1,1nr -k2,2nr | sed 's/file_/filtered_/' | cut -d' ' -f3
