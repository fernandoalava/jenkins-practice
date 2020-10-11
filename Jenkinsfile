stage('test'){
    node('docker-jenkins-slave'){
        checkout scm
        sh 'yarn install'
        sh 'yarn testci'
    }
}
node(){
    checkout scm
    stage('build docker image'){
        withDockerServer([uri: '${DOCKER_HOST}']) {
            docker.build 'falavaz/jenkinswebapp:pipeline'
        }
    }
    stage('push docker image to docker hub'){
        withDockerServer([uri: '${DOCKER_HOST}']) {
            withDockerRegistry(credentialsId: 'docker-hub') {
                docker.image('falavaz/jenkinswebapp:pipeline').push()
            }
            
        }
    }
     stage('deploy the image to staging server '){
        withDockerServer([uri: '${STAGING}']) {
           sh 'docker-compose pull' 
           sh 'docker-compose -p webapp_staging up -d'
        }
        input "Application is good?"
        withDockerServer([uri: '${STAGING}']) {
           sh 'docker-compose -p webapp_staging down -v'
        }
    }
    stage('deploy in production'){
        withDockerServer([uri: '${PRODUCTION}']) {
           sh 'docker stack deploy -c docker-stack.yml fernandoapp'
        }
    }
}