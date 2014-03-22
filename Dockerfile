# speedseq
#
# VERSION 0.0.1a

FROM ubuntu
MAINTAINER John Wregglesworth <wregglej@iplantcollaborative.org>


# Make sure Ubuntu is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update


# Taken straight from the speedseq README.
RUN apt-get install build-essential cmake gpp gcc git make python2.7 python-dev python-yaml ncurses-dev zlib1g-dev


# Have to go through the manual installation steps since this is a bare install
#
# Install BWA

RUN curl -OL http://sourceforge.net/projects/bio-bwa/files/bwa-0.7.6a.tar.bz2 && \
    tar -xvf bwa-0.7.6a.tar.bz2 && \
    cd bwa-0.7.6a && \
    make && \
    cp bwa /usr/local/bin


