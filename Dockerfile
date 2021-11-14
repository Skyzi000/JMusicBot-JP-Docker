FROM adoptopenjdk/openjdk11:alpine-jre

ENV JMUSICBOT_VERSION=0.6.5

RUN apk update &&\
    apk add --no-cache curl

WORKDIR /jmusicbot

RUN curl -SLo JMusicBot.jar https://github.com/Cosgy-Dev/JMusicBot-JP/releases/download/${JMUSICBOT_VERSION}/JMusicBot-${JMUSICBOT_VERSION}-All.jar

COPY config.txt ./

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
