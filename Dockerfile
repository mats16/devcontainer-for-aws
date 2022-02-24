FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:16

ARG DEBIAN_FRONTEND=noninteractive \
    AWS_CLI_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

RUN apt update && apt -y install --no-install-recommends zip jq \
    # install AWS CLI v2
    && curl "${AWS_CLI_URL}" -o /tmp/awscli.zip \
    && unzip /tmp/awscli.zip -d /tmp \
    && /tmp/aws/install \
    && rm -f /tmp/awscli.zip \
    # patch for AWS AMplify/AWS CDK to use AWS SSO
    && aws configure set credential_process aws-sso-credential-process \
    && touch ~/.aws/credentials \
    # Clean up
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY ./utils/aws-sso-credential-process /usr/local/bin/aws-sso-credential-process
