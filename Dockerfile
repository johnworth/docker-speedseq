# speedseq
#
# VERSION 0.0.1a

FROM ubuntu
MAINTAINER John Wregglesworth <wregglej@iplantcollaborative.org>


# Make sure Ubuntu repos are up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update


# Taken straight from the speedseq README.
RUN apt-get install -y build-essential cmake gpp gcc git make python2.7 python-dev python-yaml ncurses-dev zlib1g-dev curl vim wget


# Install speedseq

RUN git clone https://github.com/cc2qe/speedseq.git && \
    cd speedseq && python speedseq_setup.py && \
    cp -r bin/* /usr/local/bin/

CMD ["/usr/local/bin/speedseq"]
