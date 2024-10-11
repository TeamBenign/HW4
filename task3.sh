#!/bin/bash

# Convert the line endings from Windows (CRLF) to Unix (LF). Then proceed
filtered_data_avg=$(sed -i 's/\r$//' titanic.csv & \
gawk -v FPAT="[^,\"]*|\"([^\"]|\"\")*\"" '$3==2 && $12=="S" { print  $0}' titanic.csv | \
sed 's/female/F/g; s/male/M/g' | \
gawk -v FPAT="[^,\"]*|\"([^\"]|\"\")*\"" '$6 != "" {sum += $6;count++} END {print sum/count}')
echo $filtered_data_avg