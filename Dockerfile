FROM alpine:3.23 AS builder

ARG JMUSICBOT_VERSION=0.11.0
ARG JAR_PREFIX=JMusicBot-

WORKDIR /build

RUN apk update && apk add --no-cache curl jq

RUN JAR_URL=$(curl -s "https://api.github.com/repos/Cosgy-Dev/JMusicBot-JP/releases/tags/${JMUSICBOT_VERSION}" | \
    jq -r ".assets[] | select(.name | startswith(\"${JAR_PREFIX}\") and endswith(\".jar\")) | .browser_download_url" | head -n 1) && \
    echo "Downloading: ${JAR_URL}" && \
    curl -SLo JMusicBot.jar "${JAR_URL}"

FROM bellsoft/liberica-openjre-alpine:25 AS runtime

WORKDIR /jmusicbot

RUN apk update && apk add --no-cache ffmpeg

COPY --from=builder /build/JMusicBot.jar .

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
