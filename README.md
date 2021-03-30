# cakePHP docker 環境

これは、cakePHP をdocker環境で構築するためのものです。

## 使い方

まずはクローン

```
git clone {このリポジトリ}
```

以下（管理者権限必須）  
ビルド！（docker-compose .yml があるところで）

```bash
sudo docker-compose build
```

実行

```bash
sudo docker-compose up -d
```

docker の状況を確認

```bash
sudo docker ps
```

cake_php コンテナの中に入る

```bash
sudo docker exec -it cake_php bash
```

そうすると、このディレクトリ（/var/www/html/cake ）にいると思うのでここで

```bash
curl -s https://getcomposer.org/installer | php
```

そのあと

```bash
php composer.phar create-project --prefer-dist cakephp/app:4.* cms
```

* `cms` のところを変えるとプロジェクトのディレクトリが変更可能

ホストの切り替え

```hosts
127.0.0.1 cms.cake.com
```

## 表示確認

http://cms.cake.com/

これでデフォルトページが見れたら OK  
注意 ローカルホストでは見れません！

## DB 接続方法

docker-compose で mysql サーバーも建っているるかと思うので app/cake/cms/config/app_local.php 上のDB 接続情報を上書き

```
    'username' => 'cake',
    'password' => 'cake',
    'database' => 'cake_db',
    'host' => 'mysql',
```
こうすれば、接続できます！

## このシステムのバージョン
php:　7.3.27  
cake: 4.2.4 Strawberry

mysql: 5.6
