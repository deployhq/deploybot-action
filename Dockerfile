FROM alpine:latest

LABEL "com.github.actions.name"="DeployBot Action"
LABEL "com.github.actions.description"="Trigger a deploybot deployment using Github Actions"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="purple"

LABEL version="0.0.1"
LABEL repository="https://github.com/deployhq/deploybot-action"
LABEL homepage="https://www.deploybot.com/"
LABEL maintainer="Support DeployBot <support@deploybot.com>"

RUN apk update && apk add openssl curl

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
