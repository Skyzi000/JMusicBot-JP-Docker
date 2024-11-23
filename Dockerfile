FROM alpine:latest AS builder

ENV JMUSICBOT_VERSION=0.10.0-pre.1

WORKDIR /build
RUN apk update &&\
    apk add --no-cache curl

RUN curl -SLo JMusicBot.jar https://github.com/Cosgy-Dev/JMusicBot-JP/releases/download/${JMUSICBOT_VERSION}/JMusicBot-${JMUSICBOT_VERSION}-All.jar


FROM adoptopenjdk/openjdk11:alpine-jre

WORKDIR /jmusicbot
COPY --from=builder /build .
RUN apk update &&\
    apk add --no-cache ffmpeg python3 py3-pip python3-dev gcc musl-dev &&\
    python3 -m pip install -U --pre --no-cache-dir yt-dlp &&\
    apk del py3-pip python3-dev gcc musl-dev

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
