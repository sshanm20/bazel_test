pipeline {
    agent any

    stages {
        
        stage ('Verify Bazel') {
            steps {
                sh '/usr/local/bin/bazel --version'
                sh 'echo $PATH'
                sh 'printenv'
            }
        }

        stage ('Build project') {
            steps {
                sh '/usr/local/bin/bazel build @bl-app//:v710_BL.elf --platforms=@custom_platforms//:ccarm'
            }
        }

        stage ('Generate dep.graph') {
            steps {
                sh '/usr/local/bin/bazel query --noimplicit_deps "deps(@bl-app//:v710_BL.elf)" --output graph'
            }
        }
    }
}
