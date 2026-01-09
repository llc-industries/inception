FROM alpine:3.22

RUN apk update && apk upgrade && apk add nginx openssl

COPY /conf/nginx.conf /etc/nginx

EXPOSE 443

# ENTRYPOINT ["/usr/sbin/nginx"]
# CMD ["-g", "daemon off;"]
