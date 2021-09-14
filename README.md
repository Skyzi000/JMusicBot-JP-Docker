# JMusicBotJP Docker

[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/Skyzi000/JMusicBot-JP-Docker?label=latest)](https://github.com/Skyzi000/JMusicBot-JP-Docker/pkgs/container/jmusicbot-jp-docker)
[![Last Commit](https://img.shields.io/github/last-commit/Skyzi000/JMusicBot-JP-Docker)](https://github.com/Skyzi000/JMusicBot-JP-Docker/commits)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/Skyzi000/JMusicBot-JP-Docker/Docker)](https://github.com/Skyzi000/JMusicBot-JP-Docker/actions/workflows/docker-publish.yml)

[JMusicBotJP](https://github.com/Cosgy-Dev/JMusicBot-JP)を勝手にDockerイメージにしたものです。

## 使い方(docker-composeを使用)

1. このリポジトリをクローンするか[Download ZIP](https://github.com/Skyzi000/JMusicBot-JP-Docker/archive/refs/heads/main.zip)する
2. Botアカウントを作成する(参考: https://www.cosgy.dev/2019/09/06/jmusicbot-setup/#toc5 )
3. Botをサーバーに入れる(参考: https://www.cosgy.dev/2019/09/06/jmusicbot-setup/#toc6 )
4. `config.txt`を編集する(参考: https://www.cosgy.dev/2019/09/06/jmusicbot-setup/#toc7)
5. このフォルダに`cd`してから`docker-compose up -d`で起動する

## 常時起動させる

`docker-compose.yml`の
```yml
        # restart: always
```
を
```yml
        restart: always
```
に変更してから起動する
