FROM jenkins/inbound-agent:alpine
USER root
# Alpine seems to come with libcurl baked in, which is prone to mismatching
# with newer versions of curl. The solution is to upgrade libcurl.
RUN apk update && apk add -u libcurl curl
# Install Docker client
ARG DOCKER_VERSION=20.10.6
ARG KUBECTL_VERSION=1.21.1
RUN curl -fsSL https://download.docker.com/linux/static/stable/`uname -m`/docker-$DOCKER_VERSION.tgz | tar --strip-components=1 -xz -C /usr/local/bin docker/docker
#RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
#	&& chmod +x ./kubectl \
#	&& mv ./kubectl /usr/local/bin/kubectl
RUN curl -fsSL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl
RUN touch /debug-flag
USER jenkins
LABEL org.opencontainers.image.source https://github.com/nvtienanh/dind-kubectl
