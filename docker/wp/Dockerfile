FROM wordpress:5.2-php7.3-apache

#wp-cliのインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
     && chmod +x wp-cli.phar \
     && mv wp-cli.phar /usr/local/bin/wp \
     && wp --info