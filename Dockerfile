FROM alpine:latest AS builder

ENV JMUSICBOT_VERSION=0.10.2
ENV JAR_PREFIX=JMusicBot-

WORKDIR /build
RUN apk update &&\
    apk add --no-cache curl jq

# GitHub Releases API から JMusicBot- で始まる jar ファイルを動的に取得
RUN JAR_URL=$(curl -s "https://api.github.com/repos/Cosgy-Dev/JMusicBot-JP/releases/tags/${JMUSICBOT_VERSION}" | \
    jq -r ".assets[] | select(.name | startswith(\"${JAR_PREFIX}\") and endswith(\".jar\")) | .browser_download_url" | head -n 1) && \
    echo "Downloading: ${JAR_URL}" && \
    curl -SLo JMusicBot.jar "${JAR_URL}"

FROM adoptopenjdk/openjdk11:alpine-jre AS runtime

WORKDIR /jmusicbot
COPY --from=builder /build .
RUN apk update &&\
    apk add --no-cache ffmpeg python3 py3-pip python3-dev gcc musl-dev &&\
    python3 -m pip install -U --pre --no-cache-dir yt-dlp &&\
    apk del py3-pip python3-dev gcc musl-dev

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
