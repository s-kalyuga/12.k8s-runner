FROM ubuntu:latest

RUN apt-get update && apt upgrade -y \
    && apt install curl sudo -y \
    && useradd -m runner \
    && usermod -aG sudo runner \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER runner

WORKDIR /home/runner

RUN mkdir actions-runner && cd actions-runner

RUN curl -o actions-runner-linux-x64-2.294.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.294.0/actions-runner-linux-x64-2.294.0.tar.gz

RUN tar xzf ./actions-runner-linux-x64-2.294.0.tar.gz && sudo ./bin/installdependencies.sh

RUN ./config.sh

CMD [./run.sh]
