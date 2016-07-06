FROM area51/java:serverjre-8
MAINTAINER Peter Mount <peter@retep.org>

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
