FROM 137112412989.dkr.ecr.ap-northeast-1.amazonaws.com/amazonlinux:latest
MAINTAINER tomiyan <tomiyanx@gmail.com>
RUN yum update -y
RUN yum install gcc44 gcc-c++ libgcc44 cmake wget git aws-cli -y
RUN wget http://nodejs.org/dist/v4.3.2/node-v4.3.2.tar.gz
RUN tar zxfv node-v4.3.2.tar.gz
WORKDIR node-v4.3.2
RUN ./configure
RUN make
RUN make install
RUN npm -g update npm
RUN /usr/local/bin/npm install aws-sdk@2.6.3 -g
RUN mkdir /root/.aws
WORKDIR /root/.aws
COPY aws_config config
COPY aws_credentials credentials
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/tomiyan/lambda-sqlite3-sample.git
WORKDIR /app/lambda-sqlite3-sample
COPY .env /app/lambda-sqlite3-sample/.env
RUN npm i -S
RUN npm run deploy
