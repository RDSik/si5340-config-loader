FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    make \
    g++ \
    libreadline-dev \
    verilator
    # git \
    # bison \
    # flex \
    # gperf \
    # autoconf \

# RUN git clone https://github.com/verilator/verilator && \
    # cd verilator && \
    # autoconf && \
    # ./configure && \
    # make install 

COPY . .

RUN make