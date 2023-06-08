pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin/:$PATH" }
    
    stages {
        stage ('Verify Bazel') {
            steps {
                sh 'bazel --version'
            }
        }

        stage ('Build project') {
            steps {
                sh 'bazel build @bl-app//:v710_BL.elf --platforms=@custom_platforms//:ccarm'
            }
        }

        stage ('Generate dep.graph') {
            steps {
                sh 'bazel query --noimplicit_deps "deps(@bl-app//:v710_BL.elf)" --output graph'
            }
        }
    }
}
