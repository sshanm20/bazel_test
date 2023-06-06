pipeline {
    agent any

    stages {
        
        stage ('Verify Bazel') {
            steps {
                sh '/usr/local/bin/bazel --version'
            }
        }

        stage ('Build the project') {
            steps {
                sh '/usr/local/bin/bazel build //:'
            }
        }

        stage ('Make dependancy graph') {
            steps {
                sh '/usr/local/bin/bazel query --noimplicit_deps "deps(//:main)" --output graph'
            }
        }
    }
}