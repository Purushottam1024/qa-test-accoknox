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
