FROM alpine:3.23 AS builder

ARG JMUSICBOT_VERSION=0.11.0
ARG JAR_PREFIX=JMusicBot-

WORKDIR /build

RUN apk update && apk add --no-cache curl jq

RUN JAR_URL=$(curl -s "https://api.github.com/repos/Cosgy-Dev/JMusicBot-JP/releases/tags/${JMUSICBOT_VERSION}" | \
    jq -r ".assets[] | select(.name | startswith(\"${JAR_PREFIX}\") and endswith(\".jar\")) | .browser_download_url" | head -n 1) && \
    echo "Downloading: ${JAR_URL}" && \
    curl -SLo JMusicBot.jar "${JAR_URL}"

RUN curl -SLo yt-dlp "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_musllinux" && \
    chmod +x yt-dlp

FROM eclipse-temurin:25-jre-alpine-3.23 AS runtime

WORKDIR /jmusicbot

RUN apk update && apk add --no-cache ffmpeg

COPY --from=builder /build/JMusicBot.jar .
COPY --from=builder /build/yt-dlp /jmusicbot/bin/yt-dlp

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
