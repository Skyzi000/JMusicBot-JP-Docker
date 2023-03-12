FROM alpine:latest AS builder

ENV JMUSICBOT_VERSION=0.8.1

WORKDIR /build
RUN apk update &&\
    apk add --no-cache curl

RUN curl -SLo JMusicBot.jar https://github.com/Cosgy-Dev/JMusicBot-JP/releases/download/${JMUSICBOT_VERSION}/JMusicBot-${JMUSICBOT_VERSION}.jar


FROM adoptopenjdk/openjdk11:alpine-jre

WORKDIR /jmusicbot
COPY --from=builder /build .

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
