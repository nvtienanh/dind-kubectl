FROM jenkins/inbound-agent:alpine
USER root

RUN apk update && apk add --no-cache docker-cli libcurl curl

ARG KUBECTL_VERSION=1.24.9
RUN curl -LO https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl \
&& chmod +x kubectl \
&& mv kubectl /usr/local/bin/kubectl

RUN touch /debug-flag
USER jenkins
LABEL org.opencontainers.image.source https://github.com/nvtienanh/dind-kubectl