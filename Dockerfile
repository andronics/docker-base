FROM alpine:3.18.2

LABEL org.opencontainers.image.authors="andronics@gmail.com" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/andronics/docker-base.git" \
    org.opencontainers.image.vendor="Andronics Base Image" \
    org.opencontainers.image.url="https://github.com/andronics/docker-base" \
    org.opencontainers.image.vendor="andronics"

RUN \
    echo "# Add Community Edge Repository #" && \
        echo "@community https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "# Installing Packages #" && \
        apk --no-cache --update add \
            bash=5.2.15-r5 \
            ca-certificates=20230506-r0 \
            curl=8.2.0-r1 \
            jq=1.6-r3 \
            nano=7.2-r1 \
            runit=2.1.2-r7 \
            tzdata=2023c-r1 && \
    echo "# Removing Cache #" && \
        rm -rf /var/cache/apk/* && \
    echo "# Creating Folders #" && \
        mkdir \
            -p /etc/services.d && \
    echo "# Chaning Permissions #" && \
        find /etc/services -type f -exec chmod u+x {} \;

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /etc/services.d

CMD ["runsvdir", "/etc/services.d"]