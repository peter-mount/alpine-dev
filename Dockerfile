FROM area51/jenkins-slave
MAINTAINER Peter Mount <peter@retep.org>

COPY docker-entrypoint.sh /
COPY start-ssh /usr/local/bin/
RUN chmod 555 /usr/local/bin/start-ssh

ENTRYPOINT []

# Our required packages. Java is from the parent image

RUN apk add --update \
        alpine-sdk \
        autoconf \
        automake \
        cmake \
        cvs \
        git \
        mercurial \
        subversion \
        vim

# Don't remove apt lists as we want something present in most builds if we then add additional packages
#    rm -rf /var/lib/apt/lists/*
