pipeline {
    agent {
        node {
            label 'charon'
        }
    }

    parameters {
        choice(name: 'SKETCH', choices: ['rc_keyboard', 'ble_keyboard', 'ble_keyboard_esp32c3', ], description: 'Enter the name of sketch:')
    }

    options {
        ansiColor('xterm')
        disableConcurrentBuilds(abortPrevious: true)
        buildDiscarder(logRotator(numToKeepStr: '10', daysToKeepStr: '10'))
    }

    environment {
        root_dir = '/home/pi/docker_files/nfc-toolkit'
    }

    stages {
        stage("Prepare folders") {
            steps {
                sh "echo Build sketch: ${SKETCH}"
                sh "mkdir -p ${workspace_dir}"
                sh "sudo chmod 777 ${workspace_dir}"
                sh "sudo rm -rf ${workspace_dir}/*"
            }
        }
        stage("Copy code") {
            steps {
                checkout scm
                sh "bash ${SKETCH}/build_helper.sh -W ${WORKSPACE} -w ${workspace_dir} -s ${SKETCH} || cp platformio.ini ${SKETCH}/*.ino  ${workspace_dir}"
            }
        }
        stage("Check device") {
            steps {
                sh "ls -l /dev/ttyUSB0"
                sh "kill \$(ps aux | grep '/dev/ttyUSB0' | awk '{print \$2}') || echo 'All screen session are killed!'"
            }
        }
        stage("Compile") {
            steps {
                sh """
                    cd "${platformio_dir}"
                    docker-compose up
                    rtn_code=\$(docker-compose ps -q | xargs docker inspect -f '{{ .State.ExitCode }}')
                    echo "Return code: \${rtn_code}"
                    exit "\${rtn_code}"
                """
                sh """
                    docker rm -f platformio-core
                    echo "View serial output: screen /dev/ttyUSB0 115200"
                """
            }
        }
    }

    post {
        always {
            cleanWs(
                cleanWhenNotBuilt: false,
                deleteDirs: true,
                disableDeferredWipeout: true,
                notFailBuild: true
                    )

            echo 'Sending out notification'
            emailext (
                to: '$DEFAULT_RECIPIENTS', 
                subject: '$DEFAULT_SUBJECT',
                body: '$DEFAULT_CONTENT',
                mimeType: 'text/html'
            );  
        }
    }
}