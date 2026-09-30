FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      apache2 ca-certificates curl \
      lua5.1 liblua5.1 libluajit-5.1-2 luarocks \
      build-essential git unzip \
    && rm -rf /var/lib/apt/lists/*

# Rocks
COPY rocks.txt /tmp/rocks.txt
RUN while read -r rock ver; do \
      [ -z "$rock" ] && continue; \
      luarocks --lua-version 5.1 install "$rock" $ver || exit 1; \
    done < /tmp/rocks.txt

# Apache
RUN a2enmod proxy proxy_fcgi rewrite headers setenvif \
    && a2dissite 000-default \
    && echo 'Listen ${PORT}' > /etc/apache2/ports.conf

COPY apache/site.conf /etc/apache2/apache2.conf
RUN a2ensite site

# Preprocessor binary and site
RUN mkdir -p /opt/sm
RUN curl -L https://github.com/IEatUranium238/silvermoon/releases/latest/download/silvermoon \
    -o /opt/sm/silvermoon \
    && chmod +x /opt/sm/silvermoon

COPY site/ /var/www/site/

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
CMD ["/start.sh"]