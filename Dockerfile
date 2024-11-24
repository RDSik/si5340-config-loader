FROM ubuntu:latest

COPY . .

RUN apt-get update && \
    apt-get upgrade && \
    apt-get install \
    make \
    g++ \
    git \
    bison \
    flex \
    gperf \
    libreadline-dev \
    autoconf \
    python3

RUN git clone https://github.com/verilator/verilator && \
    cd verilator && \
    autoconf && \
    ./configure && \
    make install 

RUN cd ../ && \
    make