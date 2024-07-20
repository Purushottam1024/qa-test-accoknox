import requests
import pytest
import subprocess


@pytest.fixture
def get_minikube_ip():
    try:
        # Fetch Minikube IP using subprocess
        result = subprocess.run(["minikube", "ip"], capture_output=True, text=True, check=True)
        minikube_ip = result.stdout.strip()
        return minikube_ip
    except subprocess.CalledProcessError as e:
        pytest.fail(f"Failed to get Minikube IP: {e}")


@pytest.fixture
def backend_url():
    return "http://localhost:3000/greet"


@pytest.fixture
def frontend_url(get_minikube_ip):
    minikube_ip = get_minikube_ip
    return f"http://{minikube_ip}:30001"


def test_backend_service(backend_url):
    # Fetch the message from the backend service
    response = requests.get(backend_url)

    # Check that the backend service is reachable and returns the correct status code
    assert response.status_code == 200, "Backend service is not reachable"

    # Check that the response contains the expected message
    backend_message = response.json().get("message", "")
    assert backend_message == "Hello from the Backend!", "Unexpected message from the backend"


def test_frontend_service(frontend_url, backend_url):
    # Fetch the message from the backend service
    backend_response = requests.get(backend_url)
    assert backend_response.status_code == 200, "Backend service is not reachable"
    backend_message = backend_response.json().get("message", "")

    # Fetch the HTML content from the frontend service
    frontend_response = requests.get(frontend_url)
    assert frontend_response.status_code == 200, "Frontend service is not reachable"

    # Check if the frontend contains the backend message
    assert backend_message in frontend_response.text, "Frontend does not display the correct message from the backend"
