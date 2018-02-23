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
      vim \
      make \
      gcc \
      g++ \
      python \
      linux-headers \
      paxctl \
      libgcc \
      libstdc++
