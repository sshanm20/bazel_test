pipeline {
    agent any

    stages {
        
        stage ('Verify Bazel & GCC') {
            steps {
                sh '/usr/local/bin/bazel --version'
                sh '/usr/bin/gcc --version'
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
