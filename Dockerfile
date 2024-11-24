FROM ubuntu:latest

COPY . .

RUN apt-get -y update && \
    apt-get install -y \
    make \
    g++ \
    git \
    bison \
    flex \
    gperf \
    libreadline-dev \
    autoconf

RUN git clone https://github.com/verilator/verilator && \
    cd verilator && \
    autoconf && \
    ./configure && \
    make install 

RUN cd ../ && \
    make