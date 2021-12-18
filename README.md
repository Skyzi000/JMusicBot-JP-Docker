# JMusicBotJP Docker

[![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/skyzi000/jmusicbot-jp/latest)](https://hub.docker.com/r/skyzi000/jmusicbot-jp/tags?page=1&ordering=last_updated)
[![Docker Pulls](https://img.shields.io/docker/pulls/skyzi000/jmusicbot-jp)](https://hub.docker.com/r/skyzi000/jmusicbot-jp)
[![Last Commit](https://img.shields.io/github/last-commit/Skyzi000/JMusicBot-JP-Docker)](https://github.com/Skyzi000/JMusicBot-JP-Docker/commits)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/Skyzi000/JMusicBot-JP-Docker/Docker)](https://github.com/Skyzi000/JMusicBot-JP-Docker/actions/workflows/docker-publish.yml)

[JMusicBotJP](https://github.com/Cosgy-Dev/JMusicBot-JP)を勝手にDockerイメージにしたものです。

## 特徴

- 常時起動が簡単
- 更新が簡単
- 圧縮されたイメージサイズが非常に小さい(70~80MB程度)！
- Dockerがわからなくても(多分)使える

## 初回起動(docker-composeを使用)

1. このリポジトリをクローンするか[Download ZIP](https://github.com/Skyzi000/JMusicBot-JP-Docker/archive/refs/heads/main.zip)する
2. Botアカウントを作成する(参考: <https://www.cosgy.dev/2019/09/06/jmusicbot-setup/#toc5> )
3. Botをサーバーに入れる(参考: <https://www.cosgy.dev/2019/09/06/jmusicbot-setup/#toc6> )
4. `config.txt`を編集する(参考: <https://www.cosgy.dev/2019/09/06/jmusicbot-setup/#toc7>)
5. この`docker-compose.yml`のあるフォルダに移動(`cd`)する
6. `docker-compose up -d`で起動する

## 停止方法

1. この`docker-compose.yml`のあるフォルダに移動(`cd`)する
2. `docker-compose down`で停止する

## 更新方法

1. この`docker-compose.yml`のあるフォルダに移動(`cd`)する
2. `docker-compose pull`で新しいイメージを入手する
3. `config.txt`が更新されていたら更新する
4. `docker-compose up -d`で起動する

## 常時起動させる

`docker-compose.yml`の

```yml
        # restart: always
```

を

```yml
        restart: always
```

に変更(コメントアウトを解除)してから起動する
