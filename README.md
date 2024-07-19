# Problem Statement 2 (Solution-1)

## System Health Monitoring Script

### Overview

This script continuously monitors the health of a Linux system by checking CPU usage, memory usage, disk space, and the number of running processes. If any of these metrics exceed predefined thresholds, it prints an alert to the terminal and logs the alert to a file.

### Features

- Monitors CPU usage, memory usage, disk space, and number of running processes.
- Alerts and logs any metric that exceeds its threshold.
- Provides real-time feedback by printing alerts to the terminal.
- Saves logs to a specified log file.

## Requirements

- Linux-based operating system
- Bash shell
- Basic command-line tools (`top`, `grep`, `sed`, `awk`, `free`, `df`, `ps`, `wc`)

### Configuration

1. **Thresholds**: The script uses default thresholds:
   - **CPU Usage**: 80%
   - **Memory Usage**: 80%
   - **Disk Space Usage**: 80%
   
   Adjust these thresholds in the script as needed.

2. **Log File**: The log file is set to `/var/log/system_health.log`. Ensure the script has the necessary permissions to write to this file, or modify the path as needed.

### Running Steps

1. **Save the Script**:
   - Save the script content to a file, e.g., `system_health_monitor.sh`.

2. **Make it Executable**:
   - Open a terminal and run the command: `chmod +x system_health_monitor.sh` to make the script executable.

3. **Run the Script**:
   - Execute the script by running: `./system_health_monitor.sh` in the terminal.

4. **Monitoring**:
   - The script will start and continuously print alerts to the terminal and log them to the specified log file.
   - To stop the script, press `Ctrl+C` in the terminal.

### Notes

- The script runs indefinitely and checks system health every 60 seconds. You can adjust the sleep interval within the script if needed.
- Ensure that the log file path `/var/log/system_health.log` is writable or change it according to your permissions.


# Problem Statement 2 (Solution-4)

## Application Health Checker

### Overview
The **Application Health Checker** script is designed to monitor the uptime of a web application by checking its HTTP status code. It determines whether the application is functioning correctly (`'up'`) or is unavailable (`'down'`).

### Features
- **HTTP Status Check**: Evaluates application status based on HTTP status codes.
- **Configurable Interval**: Allows setting the interval between successive checks.
- **Command-Line Interface**: User-friendly with command-line arguments.

### Installation
No installation is required. Ensure that Python is installed on your system.

### Usage
To use the Application Health Checker, run the script with the following command:

    python health_checker.py <url> [--interval <seconds>]
    or
    python3 health_checker.py <url> [--interval <seconds>]

#### Parameters
- `<url>`: The URL of the application to monitor (e.g., `http://example.com`).
- `--interval <seconds>` (optional): Time interval (in seconds) between checks. Default is 30 seconds.

#### Example
To check the status of `http://example.com` every 60 seconds, use:

    python health_checker.py http://example.com --interval 60
    or
    python3 health_checker.py http://example.com --interval 60


### Script Details

#### `check_application_status(url)`
This function sends an HTTP GET request to the specified URL and checks the response status code.
- **Returns**: `'up'` if the status code is 200; otherwise, `'down'`.

#### `main()`
- Parses command-line arguments.
- Continuously checks the application status at the specified interval.
- Handles interruptions and exits gracefully.

### Error Handling
The script handles errors by assuming the application is down if an exception occurs during the HTTP request.



