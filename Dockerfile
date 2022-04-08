FROM alpine:latest AS builder
ENV JMUSICBOT_VERSION=0.6.7

WORKDIR /build
RUN apk update &&\
    apk add --no-cache curl

RUN curl -SLo JMusicBot.jar https://github.com/Cosgy-Dev/JMusicBot-JP/releases/download/${JMUSICBOT_VERSION}/JMusicBot-${JMUSICBOT_VERSION}.jar


FROM eclipse-temurin:11-jre-alpine
WORKDIR /jmusicbot
COPY --from=builder /build .

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
