FROM alpine:latest
MAINTAINER Eric Lubow <eric@lubow.org>

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

RUN apk --update add \
    bash \
    curl \
    ca-certificates \
    openssl \
    git \
    wget \
    jq \
    python \
    py-virtualenv \
    openjdk7-jre-base \
    openssh-client \
    readline
RUN apk --update add --virtual build-dependencies libffi-dev openssl-dev python-dev py-pip build-base py-openssl

RUN echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf
RUN rm /var/cache/apk/*

RUN adduser -s /bin/bash -G users -D dcoscli
WORKDIR /home/dcoscli
USER dcoscli
RUN mkdir -p /home/dcoscli/.dcos \
    && mkdir -p /home/dcoscli/.dcos/cache
COPY dcos.toml /tmp/
RUN cp /tmp/dcos.toml /home/dcoscli/.dcos/dcos.toml && chmod 600 /home/dcoscli/.dcos/dcos.toml

RUN virtualenv -p python . \
    && bash -c \
    'source bin/activate \
    && pip install --upgrade httpie \
    && pip install --upgrade dcoscli \
    && deactivate'

CMD ["/bin/bash", "/usr/local/bin/dcos.sh"]

# Add local files as late as possible to stay cache friendly`
COPY dcos.sh /usr/local/bin/
