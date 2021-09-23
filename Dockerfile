FROM adoptopenjdk/openjdk11:x86_64-alpine-jre-11.0.12_7

ENV JMUSICBOT_VERSION=0.6.4

RUN apk update &&\
    apk add --no-cache curl

WORKDIR /jmusicbot

RUN curl -SLo JMusicBot.jar https://github.com/Cosgy-Dev/JMusicBot-JP/releases/download/${JMUSICBOT_VERSION}/JMusicBot-${JMUSICBOT_VERSION}.jar

COPY config.txt ./

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
