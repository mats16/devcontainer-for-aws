FROM public.ecr.aws/amazoncorretto/amazoncorretto:17 as corretto

FROM ghcr.io/mats16/devcontainer-for-aws:node16

ARG DEBIAN_FRONTEND=noninteractive

# install java for Amplify mocking
COPY --from=corretto /usr/lib/jvm /usr/lib/jvm
RUN ln -s /usr/lib/jvm/java-17-amazon-corretto/bin/java /usr/bin/java

# patch to use Amplify CLI with AWS SSO
RUN aws configure set credential_process aws-sso-credential-process \
    && touch ~/.aws/credentials
