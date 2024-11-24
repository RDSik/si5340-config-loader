FROM ubuntu:latest

COPY . .

RUN apk update && \
    apk upgrade && \
    apk add \
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