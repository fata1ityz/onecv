# Apache HTTP Error Monitoring Script

This script monitors an Apache log file for HTTP 4xx and 5xx errors and sends an email alert if the error count exceeds a specified threshold.

## Requirements

- Bash shell
- `grep` and `wc` commands (typically pre-installed on most Linux distributions)
- `mail` command configured on the server
- Access to the Apache log file
- A working email address to receive alerts

## Script Overview

The script takes the path to an Apache log file as an argument, counts the number of HTTP 4xx and 5xx errors, and sends an email alert if the error count exceeds a defined threshold. It also logs the actions and results in a daily log file.

### Key Features:

- Counts HTTP 4xx and 5xx errors in the provided Apache log file.
- Sends an email alert if the error count exceeds the specified threshold (default: 100).
- Logs the results and actions taken, storing logs in a daily log file.

## How to Run the Script

1. **Download the Script:**

   Download the script and transfer it to your local machine or server.

2. **Make the Script Executable:**

   Before running the script, ensure it is executable by running the following command:

   ```bash
   chmod +x http_error_watcher.sh
   ```

3. **Run the Script:**

   The script requires the path to the Apache log file as an argument. For example:

   ```bash
   ./http_error_watcher.sh /path/to/apache_logs
   ```
   This will:
  
   - Check the Apache log file for HTTP 4xx and 5xx errors.
   - Log the error count and send an email alert if the threshold is exceeded.

4. **Set Up Cron Job:**

   To run the script periodically (e.g. every hour), you can set up a cron job. Open the crontab editor by running:

   ```bash
   crontab -e
   ```
   Add the following line to run the script every hour:
   
   ```bash
   0 * * * * /http_error_watcher.sh /path/to/apache_logs
   ```
   This will run the script every hour and log the output to a log file.

## Configuration

### Customizable Variables:
- ERROR_THRESHOLD: The number of HTTP 4xx/5xx errors after which an email alert is sent (default is 100).
- EMAIL: The email address to which the alert will be sent (change to your desired email).
- WATCHER_LOG_DIR: The script logs its actions and results to a daily log file located in the directory.

## Troubleshooting
### Permissions Issues:
Make sure the script has permission to read the Apache log file and write to the log directory.
Use sudo if necessary.

### Email Not Sent:
Ensure the mail command is properly configured on your system.
If using an external SMTP server, ensure that your mail relay is correctly set up.