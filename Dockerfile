FROM alpine
MAINTAINER Peter Mount <peter@retep.org>

RUN apk add --no-cache \
      ca-certificates \
      curl \
      wget \
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
      gfortran \
      python \
      linux-headers \
      paxctl \
      libgcc \
      libstdc++
