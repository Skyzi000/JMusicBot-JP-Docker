FROM adoptopenjdk/openjdk11:alpine as build
ENV JMUSICBOT_VERSION=0.6.5

WORKDIR /build
RUN apk update &&\
    apk add --no-cache curl

RUN curl -SLo JMusicBot.jar https://github.com/Cosgy-Dev/JMusicBot-JP/releases/download/${JMUSICBOT_VERSION}/JMusicBot-${JMUSICBOT_VERSION}-All.jar


FROM adoptopenjdk/openjdk11:alpine-jre

WORKDIR /jmusicbot
COPY --from=build /build .
COPY config.txt ./

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
