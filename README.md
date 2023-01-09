# JMusicBotJP Docker

[![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/skyzi000/jmusicbot-jp/latest?label=latest)](https://hub.docker.com/r/skyzi000/jmusicbot-jp/tags?page=1&ordering=last_updated)
[![Docker Image Version (tag beta semver)](https://img.shields.io/docker/v/skyzi000/jmusicbot-jp/beta?label=beta)](https://hub.docker.com/r/skyzi000/jmusicbot-jp/tags?page=1&ordering=last_updated)
[![Docker Pulls](https://img.shields.io/docker/pulls/skyzi000/jmusicbot-jp)](https://hub.docker.com/r/skyzi000/jmusicbot-jp)
[![Last Commit](https://img.shields.io/github/last-commit/Skyzi000/JMusicBot-JP-Docker)](https://github.com/Skyzi000/JMusicBot-JP-Docker/commits)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/Skyzi000/JMusicBot-JP-Docker/Docker)](https://github.com/Skyzi000/JMusicBot-JP-Docker/actions/workflows/docker-publish.yml)

[JMusicBotJP](https://github.com/Cosgy-Dev/JMusicBot-JP)を勝手にDockerイメージにしたものです。

## 特徴

- 常時起動が簡単
- 更新が簡単
- イメージサイズが非常に小さい(圧縮サイズが65~90MB程度)！
  - ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/skyzi000/jmusicbot-jp/latest?label=latest%20size)
  - ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/skyzi000/jmusicbot-jp/beta?label=beta%20size)
- Dockerがわからなくても(多分)使える

## 初回起動(docker-composeを使用)

1. このリポジトリをクローンするか[Download ZIP](https://github.com/Skyzi000/JMusicBot-JP-Docker/archive/refs/heads/main.zip)する
2. Botアカウントを作成する(参考: <https://www.cosgy.dev/2019/09/06/jmusicbot-setup/#toc5> )
3. Botをサーバーに入れる(参考: <https://www.cosgy.dev/2019/09/06/jmusicbot-setup/#toc6> )  
  →スラッシュコマンドを利用するためには、`applications.commands`スコープを有効にしなければならない点に注意  
  ![image](https://user-images.githubusercontent.com/38061609/162373657-efa3af49-25ba-4a24-a618-1547ea905feb.png)
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

に変更(コメントアウトを解除)してから起動します。

## プレリリース（ベータ）バージョンを利用する

`docker-compose.yml`の

```yml
        image: 'skyzi000/jmusicbot-jp:latest'
```

を

```yml
        image: 'skyzi000/jmusicbot-jp:beta'
```

に変更し、`docker-compose pull`で新しいイメージを入手してから起動します。

なお、`latest`タグが正式バージョンのみを含むのに対し、`beta`は正式バージョンとプレリリースバージョンの両方を含む予定です。  

### その他のDockerタグについて

`edge`や`main`タグは開発時のテスト用イメージのため、動作しない可能性が最も高くお勧めしません。  
`nightly`イメージは現在更新を停止しています。
