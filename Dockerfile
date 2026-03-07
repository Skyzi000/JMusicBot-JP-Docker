FROM alpine:3.23 AS builder

ARG JMUSICBOT_VERSION=0.11.0
ARG JAR_PREFIX=JMusicBot-

WORKDIR /build

RUN apk update && apk add --no-cache curl jq zip

RUN JAR_URL=$(curl -s "https://api.github.com/repos/Cosgy-Dev/JMusicBot-JP/releases/tags/${JMUSICBOT_VERSION}" | \
    jq -r ".assets[] | select(.name | startswith(\"${JAR_PREFIX}\") and endswith(\".jar\")) | .browser_download_url" | head -n 1) && \
    echo "Downloading: ${JAR_URL}" && \
    curl -SLo JMusicBot.jar "${JAR_URL}"

# Strip non-linux-x86_64 native libraries from jar
RUN zip -d JMusicBot.jar \
      "org/bytedeco/*/windows-*/*" \
      "org/bytedeco/*/macosx-*/*" \
      "org/bytedeco/*/ios-*/*" \
      "org/bytedeco/*/android-*/*" \
      "org/bytedeco/*/linux-arm*/*" \
      "org/bytedeco/*/linux-ppc*/*" \
      "org/bytedeco/*/linux-x86/*" \
      "org/bytedeco/*/linux-x86_64/*" \
      "org/bytedeco/*/linux-riscv*/*" \
      "natives/win*/*" \
      "natives/darwin/*" \
      "natives/linux-arm/*" \
      "natives/linux-armhf/*" \
      "natives/linux-aarch32/*" \
      "natives/linux-aarch64/*" \
      "natives/linux-musl-*/*" \
      "natives/linux-x86/*" \
      "com/sun/jna/win32-*/*" \
      "com/sun/jna/darwin/*" \
      "com/sun/jna/linux-arm*/*" \
      "com/sun/jna/linux-aarch64/*" \
      "com/sun/jna/linux-ppc*/*" \
      "com/sun/jna/linux-x86/*" \
      "com/sun/jna/sunos-*/*" \
      "lib/arm*/*" \
      "lib/armeabi*/*" \
      "lib/x86/*" \
      "lib/x86_64/*" \
    || true

FROM eclipse-temurin:25-jre-noble AS runtime

WORKDIR /jmusicbot

RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/JMusicBot.jar .

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot.jar" ]
