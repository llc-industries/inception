FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache curl php php-fpm php-phar php-mysqli \
	php-mbstring php-curl php-gd php-intl php-openssl php-xml php-zip php-iconv php-session \
	php-dom php-fileinfo php-json \
	&& mkdir -p /var/www/adminer \
	&& curl -L -o /var/www/adminer/adminer.php https://www.adminer.org/latest.php \
	&& sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf

ENTRYPOINT ["/usr/sbin/php-fpm83"]
CMD ["-F"]
