FROM mcr.microsoft.com/vscode/devcontainers/base:alpine

ARG NODEJS_VERSION=16 \
    GLIBC_VER=2.34-r0 \
    AWS_CLI_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

COPY ./utils/aws-sso-credential-process /usr/local/bin/aws-sso-credential-process

RUN apk --no-cache add binutils curl \
    # install glibc
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk \
    && rm -f glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk \
    # install AWS CLI v2
    && curl -sL "${AWS_CLI_URL}" -o awscli.zip \
    && unzip -q awscli.zip \
    && aws/install \
    && rm -f awscli.zip \
    # patch for AWS Amplify/AWS CDK to use AWS SSO
    && aws configure set credential_process aws-sso-credential-process \
    && touch ~/.aws/credentials \
    # install node.js for AWS CDK or other tools
    && apk add --no-cache nodejs~="${NODEJS_VERSION}" npm
