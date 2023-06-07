pipeline {
    agent any

    stages {
        
        stage ('Verify Bazel') {
            steps {
                sh '/usr/local/bin/bazel --version'
                sh 'echo $PATH'
                sh 'echo $USER'
                sh 'echo %OS%
            }
        }

        stage ('Build project') {
            steps {
                sh '/usr/local/bin/bazel build //:hello-world'
            }
        }

        stage ('Generate dep.graph') {
            steps {
                sh '/usr/local/bin/bazel query --noimplicit_deps "deps(//:hello-world)" --output graph'
            }
        }
    }
}
