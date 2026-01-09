FROM alpine:3.22

RUN apk update && apk upgrade && apk add nginx openssl

EXPOSE 443

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
