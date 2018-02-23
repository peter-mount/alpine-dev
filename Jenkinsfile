// Repository name use, must end with / or be '' for none
repository= 'area51/'

// image prefix
imagePrefix = 'nre-feeds'

// The image version, master branch is latest in docker
version=BRANCH_NAME
if( version == 'master' ) {
  version = 'latest'
}

// The architectures to build, in format recognised by docker
architectures = [ 'amd64', 'arm64v8' ]

def slaveId = {
  architecture -> switch( architecture ) {
    case 'amd64':
      return 'AMD64'
    case 'arm64v8':
      return ARM64
    default:
      return 'amd64'
  }
}

properties( [
  buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '7', numToKeepStr: '10')),
  disableConcurrentBuilds(),
  disableResume(),
  pipelineTriggers([
    upstream('/Public/Alpine/master'),
  ])
])

stage( "Checkout" ) {
  checkout scm
}

architectures.each {
  architecture -> node( slaveId( architecture ) ) {
    stage( 'Build ' + architecture ) {
      sh 'docker pull alpine'
      sh 'docker build -t ' + dockerImage( architecture ) + ' .'
    }

    stage( 'Publish ' + architecture ) {
      sh 'docker push ' + dockerImage( architecture )
    }
  }
}
