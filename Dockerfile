FROM alpine
MAINTAINER Peter Mount <peter@retep.org>

RUN apk add --no-cache \
      ca-certificates \
      curl \
      alpine-sdk \
      autoconf \
      automake \
      cmake \
      cvs \
      git \
      mercurial \
      subversion \
      valgrind \
      vim
