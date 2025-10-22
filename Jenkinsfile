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

        stage('Push to DockerHub') {
            steps {
                script {
                        echo "Logging into Docker Hub..."
                        sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
                        if (env.BRANCH_NAME == 'dev') {
                            echo "Pushing image to DEV repo..."
                            sh "docker tag ${IMAGE_NAME}:latest ${DEV_REGISTRY}:${IMAGE_TAG}"
                            sh "docker push ${DEV_REGISTRY}:${IMAGE_TAG}"
                        } else if (env.BRANCH_NAME == 'master') {
                            echo "Pushing image to PROD repo..."
                            sh "docker tag ${IMAGE_NAME}:latest ${PROD_REGISTRY}:${IMAGE_TAG}"
                            sh "docker push ${PROD_REGISTRY}:${IMAGE_TAG}"
                        } else {
                            echo "Branch ${env.BRANCH_NAME} is not dev/master — skipping push."
                        }
                    }
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
