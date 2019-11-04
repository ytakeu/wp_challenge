# WordPress

WordPress用のdocker-compose.ymlです。

## インストール

初めて起動したときは Webブラウザで <http://localhost:8000/> へアクセスして WordPress をインストールします。

```sh
$ sh ../script/setup.sh
（略）
```

管理者アカウントの例としては「wp_admin」、パスワードの例としては「)GcdnvElW4yn6nKy&H」があります。

## 使い方

起動

```sh
$ sh ../script/run.sh
（略）
```

停止は下記

```sh
$ sh ../script/stop.sh
（略）
```

## データ

データはdocker volumeにあって、ボリューム名はdocker_db_dataです。

```sh
$ docker volume ls
DRIVER              VOLUME NAME
local               docker_db_data
```

初期化したいときは削除します。

```sh
$ docker volume rm docker_db_data
（略）
```

ちなみに使っていないボリュームは下記で削除できます。

```sh
$ docker volume prune
（略）
```

データがある場所は下記のようにして調べることができます。

```sh
$ docker inspect wp51_mysql57 |grep -A 10 Mounts
        "Mounts": [
            {
                "Type": "volume",
                "Name": "docker_db_data",
                "Source": "/var/lib/docker/volumes/docker_db_data/_data",
                "Destination": "/var/lib/mysql",
                "Driver": "local",
                "Mode": "rw",
                "RW": true,
                "Propagation": ""
            }
```

## wp-cli

wp-cliをインストールしてあります。コマンドは`/usr/local/bin/wp`としてあるので、次のようにして使えます。

```sh
$ docker exec --env HOME=/var/www/html -u $(id -u) -it wp52 /bin/bash
I have no name!@xxx:/var/www/html$ wp plugin search mail
Success: Showing 10 of 3005 plugins.
+---------------------------------+-----------------------------------+--------+
| name                            | slug                              | rating |
+---------------------------------+-----------------------------------+--------+
| WP Mail SMTP by WPForms         | wp-mail-smtp                      | 86     |
| WP HTML Mail &#8211; Email Desi | wp-html-mail                      | 100    |
（略）
I have no name!@xxx:/var/www/html$ wp plugin install wp-mail-smtp
Installing WP Mail SMTP by WPForms (1.6.0)
（略）
I have no name!@xxx:/var/www/html$ wp theme search twentynineteen
Success: Showing 1 of 1 themes.
+-----------------+----------------+--------+
| name            | slug           | rating |
+-----------------+----------------+--------+
| Twenty Nineteen | twentynineteen | 72     |
+-----------------+----------------+--------+
I have no name!@xxx:/var/www/html$ wp theme list
+-----------------+----------+-----------+---------+
| name            | status   | update    | version |
+-----------------+----------+-----------+---------+
| twentynineteen  | active   | available | 1.3     |
| twentyseventeen | inactive | available | 2.1     |
| twentysixteen   | inactive | available | 1.9     |
+-----------------+----------+-----------+---------+
I have no name!@xxx:/var/www/html$ wp theme activate twentyninetee
Warning: The 'Twenty Nineteen' theme is already active.
```

## MailCatcher

MailCatcher を使ってメール送信の動作確認ができるようになっています。

- MailCatcher <https://mailcatcher.me/>

Dockerコンテナが起動したら、<http://localhost:1080/> へアクセスします。

WP Mail SMTP by WPFormsプラグインをインストールして、メーラーは Other SMTP, SMTPホスト smtp, 暗号化 なし, ポート番号 1025, Auto TLS ONと設定します。


## Link

- Quickstart: Compose and WordPress | Docker Documentation: <https://docs.docker.com/compose/wordpress/>
- wordpress - Docker Hub <https://hub.docker.com/_/wordpress/>
- 【WordPress】Docker for Mac & Docker ComposeでWordPressの開発環境を作ってみる | よしあかつき: <https://yosiakatsuki.net/blog/try-wordpress-docker-compose/>
