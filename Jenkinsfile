pipeline {
    agent any

    environment {
        DEV_REGISTRY = "bakialakshmi/dev"
        PROD_REGISTRY = "bakialakshmi/prod"
        IMAGE_NAME = "react-static-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from GitHub..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'chmod +x build.sh'
                // Pass branch name dynamically
                sh './build.sh ${BRANCH_NAME}'
            }
        }

        stage('Deploy Application') {
            when {
                branch 'dev'
            }
            steps {
                echo "Deploying DEV application..."
                sh 'chmod +x deploy.sh'
                sh './deploy.sh dev'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully for branch ${env.BRANCH_NAME}!"
        }
        failure {
            echo "❌ Pipeline failed. Please check the console output."
        }
    }
}
