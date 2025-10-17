pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {
       stage('Checkout Code') {
    steps {
        git branch: 'main', url: 'https://github.com/Yashaswini2453/flask-jenkins-terraform-dem.git'
    }
}


        stage('Build Docker Image') {
            steps {
                sh 'docker build -t flask-app .'
            }
        }

        stage('Run Terraform') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    sh '''
                    EC2_IP=$(aws ec2 describe-instances \
                        --filters "Name=tag:Name,Values=FlaskAppServer" \
                        --query "Reservations[*].Instances[*].PublicIpAddress" \
                        --output text)

                    echo "Deploying to $EC2_IP"
                    ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP "sudo docker run -d -p 5000:5000 flask-app"
                    '''
                }
            }
        }
    }
}
