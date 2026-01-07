FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache nginx openssl && mkdir -p /etc/nginx/ssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lle-cout.42.fr/UID=lle-cout"

COPY /conf/nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 443

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
