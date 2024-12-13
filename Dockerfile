FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    git \
    help2man \
    perl \
    python3 \
    make \
    autoconf \
    g++ \
    flex \
    bison \
    ccashe \
    ibgoogle-perftools-dev \
    numactl \
    perl-doc\
    gtkwave 
    
RUN git clone https://github.com/verilator/verilator && \
    cd verilator && \
    autoconf && \
    ./configure && \
    make -j `nproc` && \
    make install 

COPY . .

RUN make
