#!/bin/bash

# Define the paths to the YAML files relative to the root directory
FRONTEND_YAML_PATH="./Deployment/frontend-deployment.yaml"
BACKEND_YAML_PATH="./Deployment/backend-deployment.yaml"
NAMESPACE="my-app"

# Function to check if Minikube is running
check_minikube() {
    STATUS=$(minikube status --format "{{.Host}}")
    if [[ "$STATUS" == "Running" ]]; then
        echo "Minikube is already running."
    else
        echo "Minikube is not running or has an issue. Attempting to start Minikube..."
        minikube start
        if [ $? -ne 0 ]; then
            echo "Failed to start Minikube. Exiting."
            exit 1
        fi
    fi
}

# Function to configure Docker to use Minikube's Docker daemon
configure_docker() {
    echo "Configuring Docker to use Minikube's Docker daemon..."
    eval $(minikube -p minikube docker-env)
}

# Function to create namespace if it does not exist
create_namespace() {
    echo "Creating namespace if it does not exist..."
    kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: $NAMESPACE
EOF
}

# Function to deploy services
deploy_services() {
    # Apply backend deployment and service
    echo "Deploying backend..."
    kubectl apply -f "$BACKEND_YAML_PATH" -n $NAMESPACE

    # Apply frontend deployment and service
    echo "Deploying frontend..."
    kubectl apply -f "$FRONTEND_YAML_PATH" -n $NAMESPACE

    # Wait for services to be ready
    echo "Waiting for services to be ready..."
    sleep 30

    # Get frontend service URL
    FRONTEND_URL=$(minikube service frontend-service -n $NAMESPACE --url)

    # Port-forward backend service for local testing
    echo "Setting up port forwarding for backend service..."
    kubectl port-forward service/backend-service 3000:3000 -n $NAMESPACE &

    echo "Deployment completed."
    echo "Frontend is available at: $FRONTEND_URL"
    echo "Backend is available at: http://localhost:3000/greet (via port forwarding)"
}

# Main script execution
check_minikube
configure_docker
create_namespace
deploy_services
