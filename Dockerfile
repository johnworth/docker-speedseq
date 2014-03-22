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


# Have to go through the manual installation steps since this is a bare install
#
# Install BWA

RUN curl -OL http://sourceforge.net/projects/bio-bwa/files/bwa-0.7.6a.tar.bz2 && \
    tar -xvf bwa-0.7.6a.tar.bz2 && \
    cd bwa-0.7.6a && \
    make && \
    cp bwa /usr/local/bin


# Install freebayes

RUN git clone --recursive git://github.com/ekg/freebayes.git && \
    cd freebayes && \ 
    make && \
    cp -r bin/* /usr/local/bin/


# Install lumpy

RUN curl -OL ftp://ftp.gnu.org/gnu/gsl/gsl-1.9.tar.gz && \
    tar -xvf gsl-1.9.tar.gz && \
    cd gsl-1.9 && \
    ./configure && sudo make && sudo make install

RUN curl -o lumpy-sv-0.1.5.tar.gz -OL https://github.com/arq5x/lumpy-sv/archive/v0.1.5.tar.gz && \
    tar -xvf lumpy-sv-0.1.5.tar.gz && \
    cd lumpy-sv-0.1.5 && \
    make && \
    cp -r bin/* /usr/local/bin/ && \
    cp -r scripts/* /usr/local/bin/


# Install parallel

RUN curl -OL http://ftp.gnu.org/gnu/parallel/parallel-20100424.tar.bz2 && \
    tar -xvf parallel-20100424.tar.bz2 && \
    cd parallel-20100424 && \
    ./configure && sudo make && sudo make install && \
    cp src/parallel /usr/local/bin/


# Install sambamba

RUN curl -OL https://github.com/lomereiter/sambamba/releases/download/v0.4.4/sambamba_v0.4.4_centos5.tar.bz2 && \
    tar -xvf sambamba_v0.4.4_centos5.tar.bz2 && \
    cp sambamba_v0.4.4 /usr/local/bin/


# Install samblaster

RUN git clone git://github.com/GregoryFaust/samblaster.git && \
    cd samblaster && \
    make && \
    cp samblaster /usr/local/bin/


# Install snpff

RUN apt-get install -y openjdk-7-jre-headless
RUN apt-get install -y unzip

RUN wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip && \
    unzip snpEff_latest_core.zip && \
    cd snpEff && \
    cp *jar /usr/local/bin/ && \
    cp snpEff.config /usr/local/bin && \
    cp -r scripts/* /usr/local/bin/


# Install vcflib

RUN git clone --recursive  https://github.com/ekg/vcflib && \
    cd vcflib && \
    make && \
    sudo cp bin/* /usr/local/bin/


# Install gemini

RUN curl -o gemini_install.py -OL https://raw.github.com/arq5x/gemini/master/gemini/scripts/gemini_install.py && \
    python2.7 gemini_install.py /usr/local /usr/local/share/gemini && \
    echo "export PATH=$PATH:/usr/local/gemini/bin" >> ~/.bashrc && \
    gemini update


# Install speedseq

RUN git clone https://github.com/cc2qe/speedseq.git && \
    cd speedseq && \
    python speedseq_setup.py && \
    cp -r bin/* /usr/local/bin/

CMD ['/usr/local/bin/speedseq']
