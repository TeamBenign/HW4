#!/bin/bash

# Convert the line endings from Windows (CRLF) to Unix (LF). 
sed -i 's/\r$//' titanic.csv
# Get filtered data to extract passengers from 2nd class who embarked at Southampton 
filtered_data=$(gawk -v FPAT="[^,\"]*|\"([^\"]|\"\")*\"" '$3==2 && $12=="S" { print  $0}' titanic.csv)
echo "$filtered_data"

# Replace female and male with f and m 
filtered_data=$(echo "$filtered_data"| sed 's/female/F/g; s/male/M/g')
echo "$filtered_data"

# Calculate the average age
total_age=$(echo "$filtered_data" | gawk -v FPAT="[^,\"]*|\"([^\"]|\"\")*\"" '$6 != "" {sum += $6} END {print sum}')
num_passengers=$(echo "$filtered_data" | gawk -v FPAT="[^,\"]*|\"([^\"]|\"\")*\"" '$6 != "" {count++} END {print count}')

# Calculate average age
if [ "$num_passengers" -gt 0 ]; then
    average_age=$(echo "scale=3; $total_age / $num_passengers" | bc -l)
    echo "Average age of filtered passengers: $average_age"
else
    echo "No passengers found."
fi