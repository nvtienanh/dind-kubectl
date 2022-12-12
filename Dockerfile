ARG version=3077.vd69cf116da_6f-3
FROM jenkins/agent:${version}-alpine-jdk11

ARG version=3077.vd69cf116da_6f-3
LABEL Description="This is a base image, which allows connecting Jenkins agents via JNLP protocols" Vendor="Jenkins project" Version="$version"

ARG user=jenkins

USER root

# Install Docker CLI
RUN apk update && apk add --no-cache docker-cli
# Add Docker permissions to Jenkins user
RUN DOCKER_GID=999 && \
    delgroup $(grep $DOCKER_GID /etc/group | cut -d: -f1) && \
    addgroup -S -g $DOCKER_GID docker && addgroup jenkins docker
# RUN addgroup jenkins docker

COPY jenkins-agent /usr/local/bin/jenkins-agent
RUN chmod +x /usr/local/bin/jenkins-agent &&\
    ln -s /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-slave
USER ${user}

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]