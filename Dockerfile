# イメージを指定
# 本来であれば2016.03.3がLambda実行環境ですが、Dockerイメージは2016.09.0以降しか公開されていない
FROM amazonlinux:2016.09
MAINTAINER tomiyan <tomiyanx@gmail.com>
# yumを最新に更新
RUN yum update -y
# 必要なライブラリをインストール
RUN yum install gcc44 gcc-c++ libgcc44 cmake wget git aws-cli -y
# node.jsをインストール
RUN wget http://nodejs.org/dist/v4.3.2/node-v4.3.2.tar.gz
RUN tar zxfv node-v4.3.2.tar.gz
WORKDIR node-v4.3.2
RUN ./configure
RUN make
RUN make install
# npmを更新
RUN npm -g update npm
# aws-sdkをインストール
RUN /usr/local/bin/npm install aws-sdk@2.6.3 -g
# Lambdaデプロイ用にaws config/credentialsをコピー
RUN mkdir /root/.aws
WORKDIR /root/.aws
COPY aws_config config
COPY aws_credentials credentials
# Lambdaにデプロイしたいgitをcloneしデプロイ
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/tomiyan/lambda-sqlite3-sample.git
WORKDIR /app/lambda-sqlite3-sample
COPY .env /app/lambda-sqlite3-sample/.env
RUN npm i -S
RUN npm run deploy
