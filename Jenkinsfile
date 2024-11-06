pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "your-docker-registry-url"  // Replace with your Docker registry URL (e.g., Docker Hub, AWS ECR)
        DOCKER_IMAGE_NAME = "user-service"
        IMAGE_TAG = "${BUILD_NUMBER}"  // You can customize this tag (e.g., use Git commit hash, etc.)
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                git 'https://your-repo-url/user-service.git'
            }
        }

        stage('Build with Maven') {
            steps {
                // Clean, install, and skip tests for now (tests will run in the next stage)
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Run Maven Tests') {
            steps {
                // Run Maven tests to ensure the service works as expected
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image for the service
                    sh "docker build -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$IMAGE_TAG ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker registry (make sure to set up your credentials in Jenkins)
                    sh "docker login -u $DOCKER_USER -p $DOCKER_PASSWORD $DOCKER_REGISTRY"
                    
                    // Push the Docker image to the registry
                    sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$IMAGE_TAG"
                }
            }
        }

        // Optional: Deploy with Docker Compose
        stage('Deploy with Docker Compose') {
            steps {
                script {
                    // Deploy using Docker Compose (assuming you have docker-compose.yml)
                    sh 'docker-compose -f docker-compose.yml up -d'
                }
            }
        }
    }

    post {
        success {
            echo "Build, Docker Push, and Deployment succeeded!"
        }
        failure {
            echo "Build or Docker Push or Deployment failed!"
        }
    }
}

