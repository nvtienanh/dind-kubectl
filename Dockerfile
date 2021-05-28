FROM jenkins/slave:latest
USER root
ENV DOCKERVERSION=20.10.5-ce
ENV KUBECTLVERSION=v1.21.1

RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTLVERSION}/bin/linux/amd64/kubectl \
	&& chmod +x ./kubectl \
	&& mv ./kubectl /usr/local/bin/kubectl