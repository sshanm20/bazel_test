pipeline {
    agent any

    stages {
        
        stage ('Verify Bazel') {
            steps {
                sh 'bazel --version'
            }
        }

        stage ('Build project') {
            steps {
                sh 'bazel build //:hello-world'
            }
        }

        stage ('Generate dep.graph') {
            steps {
                sh 'bazel query --noimplicit_deps "deps(//:hello-world)" --output graph'
            }
        }
    }
}
