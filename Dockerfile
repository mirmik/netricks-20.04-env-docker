FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
      apt-get -y install apt-utils sudo software-properties-common \
      keyboard-configuration \
      libreadline-dev \
      libjsoncpp-dev \
      libmodbus-dev

RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test

RUN DEBIAN_FRONTEND=noninterative apt update -y
RUN DEBIAN_FRONTEND=noninterative apt install git cmake python3 python3-pip -y
RUN DEBIAN_FRONTEND=noninterative sudo python3 -m pip install licant
RUN DEBIAN_FRONTEND=noninterative sudo python3 -m pip install gitpython

RUN DEBIAN_FRONTEND=noninterative sudo apt install -yq g++-11 gcc-11
RUN DEBIAN_FRONTEND=noninterative sudo rm -f /usr/bin/g++
RUN DEBIAN_FRONTEND=noninterative sudo rm -f /usr/bin/gcc
RUN DEBIAN_FRONTEND=noninterative sudo ln -s /usr/bin/g++-11 /usr/bin/g++
RUN DEBIAN_FRONTEND=noninterative sudo ln -s /usr/bin/gcc-11 /usr/bin/gcc

WORKDIR /root 
RUN git clone https://github.com/ReactiveX/RxCpp
RUN git clone https://github.com/yhirose/cpp-httplib
RUN git clone https://github.com/mirmik/ircc

WORKDIR /root/RxCpp
RUN cmake .
RUN cmake --build . --config Release
RUN sudo cmake --build . --config Release --target install

WORKDIR /root/cpp-httplib
RUN cmake .
RUN cmake --build . --config Release
RUN sudo cmake --build . --config Release --target install

WORKDIR /root/ircc
RUN cmake .
RUN cmake --build . --config Release
RUN sudo cmake --build . --config Release --target install
