FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:16

ARG DEBIAN_FRONTEND=noninteractive \
    AWS_CLI_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

# install AWS CLI v2
COPY ./utils/aws-sso-credential-process /usr/local/bin/aws-sso-credential-process
RUN apt-get update && apt-get -y install --no-install-recommends zip jq \
    # install AWS CLI v2
    && curl "${AWS_CLI_URL}" -o /tmp/awscli.zip \
    && unzip /tmp/awscli.zip -d /tmp \
    && /tmp/aws/install \
    && rm -f /tmp/awscli.zip \
    # patch for AWS Amplify/AWS CDK to use AWS SSO
    && aws configure set credential_process aws-sso-credential-process \
    && touch ~/.aws/credentials 

# install docker-cli
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update && apt-get -y install --no-install-recommends docker-ce-cli

COPY ./utils/first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt
COPY ./utils/alias.txt /tmp/alias.txt
RUN cat /tmp/alias.txt >> ~/.zshrc \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/zsh \
    DOCKER_BUILDKIT=1
