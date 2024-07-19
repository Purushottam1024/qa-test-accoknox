#!/bin/bash

# Define thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Log file
LOGFILE="/var/log/system_health.log"

# Create or clear the log file
> $LOGFILE

# Print thresholds
echo "Monitoring System Health:"
echo "CPU Threshold: $CPU_THRESHOLD%"
echo "Memory Threshold: $MEMORY_THRESHOLD%"
echo "Disk Threshold: $DISK_THRESHOLD%"
echo

while true; do
    # Get CPU usage
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        ALERT="CPU usage is high: ${CPU_USAGE}%"
        echo "$(date) - $ALERT" | tee -a $LOGFILE
    fi

    # Get Memory usage
    MEMORY_USAGE=$(free | grep Mem | awk '{print ($3/$2) * 100.0}')
    if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
        ALERT="Memory usage is high: ${MEMORY_USAGE}%"
        echo "$(date) - $ALERT" | tee -a $LOGFILE
    fi

    # Get Disk space usage
    DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        ALERT="Disk space usage is high: ${DISK_USAGE}%"
        echo "$(date) - $ALERT" | tee -a $LOGFILE
    fi

    # Get running processes count (Example threshold: more than 100 processes)
    PROCESS_COUNT=$(ps aux | wc -l)
    if [ "$PROCESS_COUNT" -gt 100 ]; then
        ALERT="Number of running processes is high: ${PROCESS_COUNT}"
        echo "$(date) - $ALERT" | tee -a $LOGFILE
    fi

    # Sleep for 60 seconds before the next check
    sleep 60
done
