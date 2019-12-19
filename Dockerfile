FROM ubuntu:18.04


ARG HTTP_PROXY=
ARG HTTPS_PROXY=

ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTPS_PROXY

RUN echo HTTP_PROXY is ${HTTP_PROXY}

RUN apt-get update

RUN apt-get install -y \
    wget \
    git \
    iputils-ping \
    docker.io

ARG username=action
ARG uid=1000
ARG groupname=dockerhost
ARG gid=999

RUN groupadd -g $gid -r $groupname && \
useradd -u $uid -r -g $groupname $username

RUN mkdir -p /action && chown $username /action


WORKDIR /action
ENV HOME /action
RUN cd /action
RUN echo ${HTTP_PROXY} > .proxy

# Download the latest runner package and extract the installer
RUN wget --output-document actions-runner-linux-x64.tar.gz https://githubassets.azureedge.net/runners/2.162.0/actions-runner-linux-x64-2.162.0.tar.gz \
    && tar xzvf ./actions-runner-linux-x64.tar.gz \
    && ./bin/installdependencies.sh \
    && chown -R $username .

USER $username


#RUN $ ./config.sh --url $GITHUB_REPO_URL --token $RUNNER_TOKEN

CMD tail -f /dev/null

