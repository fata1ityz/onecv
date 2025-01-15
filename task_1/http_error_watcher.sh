#!/bin/bash

# This script monitors an Apache log file for HTTP 4xx and 5xx errors and sends an alert if the error count exceeds a threshold.

# Configurable variables
LOG_FILE=$1                               # Apache log file passed as a parameter
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S') # Current timestamp
ERROR_THRESHOLD=100                       # Threshold for sending email alerts
EMAIL="samuel.lim92@gmail.com"            # Email address to send alerts

# Location to store logs for this script (logs rotate daily)
WATCHER_LOG_DIR="/var/log/http_error_watcher"
WATCHER_LOG="$WATCHER_LOG_DIR/watcher_log_$(date '+%Y-%m-%d').log"

# Make sure log dir exists
mkdir -p "$WATCHER_LOG_DIR"

# Check if Apache log file is provided in argument
if [[ -z "$LOG_FILE" ]]; then
  echo "[$CURRENT_TIME] Error: No log file provided. Please specify log file as the argument." | tee -a "$WATCHER_LOG"
  exit 1
# Check if Apache log file exists
elif [[ ! -f "$LOG_FILE" ]]; then
  echo "[$CURRENT_TIME] Error: Log file '$LOG_FILE' not found." | tee -a "$WATCHER_LOG"
  exit 1
fi

# Count HTTP 4xx and 5xx errors in the log file
ERROR_COUNT=$(grep -E "HTTP/1\.[01]\" [45][0-9]{2}" "$LOG_FILE" | wc -l)

# Log the results
echo "[$CURRENT_TIME] Found $ERROR_COUNT HTTP 4xx/5xx errors in $LOG_FILE." | tee -a "$WATCHER_LOG"

# If error count exceed threshold, send an alert email
if (( ERROR_COUNT > ERROR_THRESHOLD )); then
  SUBJECT="ALERT: High HTTP Error Count Detected"
  MESSAGE="[$CURRENT_TIME] Found $ERROR_COUNT HTTP 4xx/5xx errors in $LOG_FILE.\nThis exceeds the threshold of $ERROR_THRESHOLD errors."
  echo -e "$MESSAGE" | mail -s "$SUBJECT" "$EMAIL"
  echo "[$CURRENT_TIME] Threshold of $ERROR_THRESHOLD exceeded. Alert email sent to $EMAIL." | tee -a "$WATCHER_LOG"
else
  echo "[$CURRENT_TIME] The number of errors ($ERROR_COUNT) is within the acceptable threshold ($ERROR_THRESHOLD). No action needed." | tee -a "$WATCHER_LOG"
fi