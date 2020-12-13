## AWSコンソールへログイン

https://aws.amazon.com/jp/console/

## EC2を起動する
- コンソール上でポチポチやります
- キーペア
  - EC2にローカルPCから接続するためのパスワードの組み合わせ（合鍵の組み合わせ）
  - 後で接続するときに使う
- セキュリティグループ
  - どこからこのEC2に接続していいかのルール
- 起動したら、EC2のコンソールにipが表示される
  - ipを控えておく ex.) 10.74.12.102
  - 後で接続するときに使う

## EC2にSSHする
```
$ ssh -i <キーペアファイルを指定> ec2-user@<控えておいたip>
```
- 意味
  - 「ec2-userで<ip>で起動しているサーバにアクセスする。その際、使うパスワードは<キーペア>」
- 「ec2-user」という名前は、今回使っているEC2インスタンスでデフォルトのユーザ名
- <ip>部分は、ドメイン名でもOK
- キーペアはファイルのパーミッションが600である必要がある
  - 不正に改竄されないように

## EC2にdockerをインストールする
```
# 依存ライブラリを最新にしておく。基本的に最新を使うのが鉄則
$ sudo yum update

# dockerをインストール(デフォルトで入っているわけではない)
$ sudo amazon-linux-extras install docker

# dockerを起動しておく
$ sudo service docker start

# dockerには強い権限が必要。ec2-userにその権限を付与
$ sudo usermod -a -G docker ec2-user

# 権限を再読み込みするため、一度接続を切って、再度接続
$ exit
$ ssh -i <キーペアファイルを指定> ec2-user@<控えておいたip>

# 表示されればec2-userでdocker実行できている!!
$ docker info

# さらにdocker-composeをインストール
$ sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# 実行権限を付与
$ sudo chmod +x /usr/local/bin/docker-compose

# 表示されれば、インストール成功
$ docker-compose version
```

## EC2でこのリポジトリをCloneする
```
# gitをインストール
$ sudo yum install git

# このリポジトリをClone
$ git clone https://github.com/machisuke/aws_ec2_tutorial_rails.git
$ cd aws_ec2_tutorial_rails
```

## EC2でアプリを起動する
# 起動
```
$ docker-compose run rails bin/setup
$ docker-compose up
```

`http://<ip>:3000`
や
`http://<ip>:3000/users`
にアクセスできる！
