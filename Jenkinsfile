// Repository name use, must end with / or be '' for none
repository= 'area51/'

// image prefix
imagePrefix = 'alpine-dev'

// The image version, master branch is latest in docker
version=BRANCH_NAME
if( version == 'master' ) {
  version = 'latest'
}

// The architectures to build, in format recognised by docker
architectures = [ 'amd64', 'arm64v8' ]

// The slave label based on architecture
def slaveId = {
  architecture -> switch( architecture ) {
    case 'amd64':
      return 'AMD64'
    case 'arm64v8':
      return 'ARM64'
    default:
      return 'amd64'
  }
}

// The docker image name
// architecture can be '' for multiarch images
def dockerImage = {
  architecture -> repository + imagePrefix + ':' +
    ( architecture=='' ? '' : ( architecture + '-' ) ) +
    version
}

// The go arch
def goarch = {
  architecture -> switch( architecture ) {
    case 'amd64':
      return 'amd64'
    case 'arm32v6':
    case 'arm32v7':
      return 'arm'
    case 'arm64v8':
      return 'arm64'
    default:
      return architecture
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

def buildArch = {
  architecture -> node( slaveId( architecture ) ) {

    stage( architecture ) {
      checkout scm

      sh 'docker pull alpine'
      sh 'docker build -t ' + dockerImage( architecture ) + ' .'

      sh 'docker push ' + dockerImage( architecture )
    }
  }
}

stage( 'Build' ) {
  parallel(
    'amd64': {
      buildArch( 'amd64' )
    },
    'arm64v8': {
      buildArch( 'arm64v8' )
    }
  )
}

node( "AMD64" ) {
  stage( "MultiArch" ) {
    // The manifest to publish
    multiImage = dockerImage( '' )

    // Create/amend the manifest with our architectures
    manifests = architectures.collect { architecture -> dockerImage( architecture ) }
    sh 'docker manifest create -a ' + multiImage + ' ' + manifests.join(' ')

    // For each architecture annotate them to be correct
    architectures.each {
      architecture -> sh 'docker manifest annotate' +
        ' --os linux' +
        ' --arch ' + goarch( architecture ) +
        ' ' + multiImage +
        ' ' + dockerImage( architecture )
    }

    // Publish the manifest
    sh 'docker manifest push -p ' + multiImage
  }
}
