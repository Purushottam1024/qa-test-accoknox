import http.client
import time
from urllib.parse import urlparse
import argparse

def check_application_status(url):
    """
    Check the status of the application by sending an HTTP GET request.
    
    Parameters:
    url (str): The URL of the application to check.
    
    Returns:
    str: 'up' if the application is responding with status code 200, otherwise 'down'.
    """
    parsed_url = urlparse(url)
    connection = http.client.HTTPConnection(parsed_url.netloc, timeout=10)
    
    try:
        connection.request("GET", parsed_url.path or "/")
        response = connection.getresponse()
        if response.status == 200:
            return 'up'
        else:
            return 'down'
    except Exception as e:
        return 'down'
    finally:
        connection.close()

def main():
    """
    Main function to parse command-line arguments and periodically check the 
    application status.
    """
    parser = argparse.ArgumentParser(description="Check the uptime of an application.")
    parser.add_argument("url", type=str, help="The URL of the application to check.")
    parser.add_argument("--interval", type=int, default=30, help="Time interval in seconds between checks.")
    
    args = parser.parse_args()
    
    url = args.url
    check_interval = args.interval

    try:
        while True:
            status = check_application_status(url)
            if status == 'up':
                print(f"The application at {url} is up.")
            else:
                print(f"The application at {url} is down.")
            time.sleep(check_interval)
    except KeyboardInterrupt:
        print("\nHealth checker closed successfully.")

if __name__ == '__main__':
    main()

