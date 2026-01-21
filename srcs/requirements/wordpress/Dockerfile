FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache mariadb-client curl php php-fpm php-phar php-mysqli php-mbstring \
	php-curl php-gd php-intl php-openssl php-xml php-zip php-iconv php-session php-dom php-fileinfo php-json \
	&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mkdir -p /usr/local/bin \
	&& mv wp-cli.phar /usr/local/bin/wp \
	&& sed -i "s|;*memory_limit =.*|memory_limit = 512M|i" /etc/php83/php.ini \
	&& sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf

COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/wordpress

ENTRYPOINT ["/usr/local/bin/setup.sh"]
