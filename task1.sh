PID=$(pgrep -f infinite.sh)

if [ -n "$PID" ]; then
	echo "Killing process with PID: $PID"
	kill $PID
	echo "Process Killed"
else
	echo "No running process found for infinite.sh"

fi
