FROM ubuntu:14.04
MAINTAINER Eric Lubow <eric@lubow.org>

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential libreadline6 readline-common && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install -y bash ca-certificates openssl jq python3 openssh-client

COPY install-package-support.sh /tmp/
RUN cp /tmp/install-package-support.sh /tmp/install-packages.sh && chmod 600 /tmp/install-packages.sh
RUN bash /tmp/install-packages.sh
RUN rm -f /tmp/install-package-support.sh && rm -f /tmp/install-packages.sh

# keep the image slim by removing caches
RUN rm -rf /var/lib/apt/lists/*

RUN echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

RUN adduser --home /home/dcoscli dcoscli
WORKDIR /home/dcoscli
USER dcoscli
RUN mkdir -p /home/dcoscli/.dcos \
    && mkdir -p /home/dcoscli/.dcos/cache
COPY dcos.toml /tmp/
RUN cp /tmp/dcos.toml /home/dcoscli/.dcos/dcos.toml && chmod 600 /home/dcoscli/.dcos/dcos.toml

RUN mkdir -p /home/dcoscli/bin
RUN curl -o /tmp/dcos https://downloads.dcos.io/binaries/cli/linux/x86-64/dcos-1.10/dcos
RUN cp /tmp/dcos /home/dcoscli/bin/dcos && chmod 755 /home/dcoscli/bin/dcos
ENV HOME=/home/dcoscli
ENV PATH=$PATH:/home/dcoscli/bin

CMD ["/bin/bash", "/usr/local/bin/dcos.sh"]

# Add local files as late as possible to stay cache friendly`
COPY dcos.sh /usr/local/bin/
