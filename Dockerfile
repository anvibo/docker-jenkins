FROM jenkins/jenkins:lts-slim

USER root

RUN apt-get update && \
    apt-get -y install --no-install-recommends apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install --no-install-recommends docker-ce && \
    apt-get remove --purge -y \
        apt-transport-https \
        software-properties-common \
        gnupg2 && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*

RUN usermod -a -G docker jenkins

USER jenkins
