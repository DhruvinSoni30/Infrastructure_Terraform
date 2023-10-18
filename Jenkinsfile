properties([ parameters([
  string( name: 'STACK_NAME', defaultValue: ''),
]), pipelineTriggers([]) ])

env.stack_name = STACK_NAME

pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    stages{
        
        stage('Git Checkout'){
            steps{
                git branch: 'main', credentialsId: 'cred', url: 'https://github.com/DhruvinSoni30/Infrastructure_Terraform'
            }
        }
        
        stage('Fetching code'){
            steps{
                sh "cd '${WORKSPACE}/Stack_Definition/${env.stack_name}' && aws s3 cp s3://stack-definition/default_vpc/main.tf . && aws s3 cp s3://stack-definition/default_vpc/variables.tf . && aws s3 cp s3://stack-definition/${env.stack_name}/provider.tf ."
            }
        }
        
        stage('Account name'){
            steps{
                script{
                    def accountName = sh (script: "python3 ${WORKSPACE}/Infrastructure_Definition/bin/cred.py -s ${env.stack_name}", returnStdout:true,).toString().trim()
                    currentBuild.description = accountName
                }
            }
        }
        
        stage('Terraform init'){
            steps{
                script{
                    def accountName = currentBuild.description
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: "${accountName}",
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                            sh "cd '${WORKSPACE}/Stack_Definition/${env.stack_name}' && terraform init"
                        }
                }
            }
        }
         
        stage('Terraform plan'){
            steps{
                script{
                    def accountName = currentBuild.description
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: "${accountName}",
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                            sh "cd '${WORKSPACE}/Stack_Definition/${env.stack_name}' && terraform plan -out myplan"
                    }
                }
            }
        }
    
        stage('Approval') {
            steps {
                script {
                    def userInput = input(id: 'Confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'Confirm'] ])
                }
            }
        }

        stage('Terraform Apply'){
            steps{
                script{
                    def accountName = currentBuild.description
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: "${accountName}",
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                            sh "cd '${WORKSPACE}/Stack_Definition/${env.stack_name}' && terraform apply -input=false myplan"
                        }
                    }
                }
        }
    }
}
    
