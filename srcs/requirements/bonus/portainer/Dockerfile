FROM alpine:3.22

WORKDIR /opt

RUN apk update && apk upgrade && apk add --no-cache curl libc6-compat \
	&& curl -sL https://github.com/portainer/portainer/releases/download/2.33.6/portainer-2.33.6-linux-amd64.tar.gz | tar -xz

ENTRYPOINT ["./portainer/portainer"]

