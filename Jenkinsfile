pipeline {
    agent {
       label 'docker-multiarch' 
    }
    environment {
        DOCKER_CREDENTIALS = credentials('github-labradorcode-credentials')
        DOCKER_IMAGE_NAME = 'bind9'
        DOCKER_IMAGE_TAG = '9.16.29-r0'
    }
    stages {
        stage('Init') {
            steps {
                echo 'Initializing..'
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "Current branch: ${env.BRANCH_NAME}"
                sh('echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin')
            }
        }
        stage('Set docker building context') {
            steps {
                echo 'Using builder as buildx context'
                sh "docker buildx use builder"
            }
        }
        stage('Build') {
            steps {
                echo 'Building image..'
                sh "docker buildx build --platform linux/amd64,linux/arm64,linux/386,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6,linux/riscv64 --pull --no-cache --push -t ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
            }
        }
    }
}