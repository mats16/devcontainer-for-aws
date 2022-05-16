FROM public.ecr.aws/docker/library/node:16-alpine AS nodejs

RUN mkdir /opt/yarn && cp -r /opt/yarn-*/* /opt/yarn/

FROM mcr.microsoft.com/vscode/devcontainers/base:alpine

COPY --from=nodejs /usr/local/bin/node /usr/local/bin/node
COPY --from=nodejs /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
COPY --from=nodejs /opt/yarn/ /opt/yarn/
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn

ARG GLIBC_VER=2.34-r0 \
    AWS_CLI_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

# install AWS CLI v2
COPY ./utils/aws-sso-credential-process /usr/local/bin/aws-sso-credential-process
RUN apk --no-cache add binutils curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk \
    && rm -f glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk \
    # install AWS CLI v2
    && curl -sL "${AWS_CLI_URL}" -o awscli.zip \
    && unzip -q awscli.zip \
    && aws/install \
    && rm -f awscli.zip

RUN apk add --no-cache docker-cli

COPY ./utils/first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt

COPY ./utils/alias.txt /tmp/alias.txt
RUN cat /tmp/alias.txt >> ~/.zshrc

ENV SHELL=/bin/zsh \
    DOCKER_BUILDKIT=1
