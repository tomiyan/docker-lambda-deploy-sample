# Docker lambda deploy sample

## 前提

* AWS Lambdaはnode.js v4.3.2を利用
* node-aws-lambdaでのデプロイ
* dotenvでnode-aws-lambdaのRole指定を行っている
* Amazon Linuxは互換性のあるものを選択できなかったので最新を選択
* 今回はサンプルとして/app/lambda-sqlite3-sampleにアプリケーションを置く

## 設定ファイルの作成

このファイルと同じディレクトリに下記を作成する

### aws_config

Lambdaのデプロイのために用意する
Dockerfileでは~/.aws/configとしてコピーする

```
[default]
```

### aws_credentials

Lambdaのデプロイのために用意する
Dockerfileでは~/.aws/credentialsとしてコピーする

```
[default]
aws_access_key_id = ABC********
aws_secret_access_key = 1234*******
```

### .env

Lambdaのroleのために用意する
Dockerfileでは/app/lambda-sqlite3-sample/.envとしてコピーする

```
ROLE=arn:aws:iam::123456****:role/role_name
```

## Dockerの実行

下記は任意の値に変更する

* user
* name
* tag-name

```bash
$ cd docker-lambda-deploy-sample
$ docker build --no-cache -t user/name:tag-name .
```

