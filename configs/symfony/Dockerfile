FROM ubuntu:latest
MAINTAINER ko.ivanov@gmail.com

# Prevent apt from trying to interact with the user and assume the default answers for any interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set default time zone
ENV TZ=Europe/Sofia

# add default user app for uid 1000
RUN useradd -ms /bin/bash app

RUN apt-get update \
    && apt-get install -y git locales-all nano curl software-properties-common supervisor iproute2\
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y  \
    php8.2-fpm \
    php8.2-bcmath \
    php8.2-common \
    php8.2-curl \
    php8.2-dev \
    php8.2-mysql \
    php8.2-odbc \
    php8.2-xmlrpc \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-zip \
    php8.2-redis \
    php8.2-soap \
    php8.2-xml \
    php8.2-xdebug \
    && apt-get clean

# Create necessary directories for PHP-FPM
RUN mkdir -p /run/php/

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install symfony cli
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash \
    && apt install symfony-cli

# Install nvm nodejs & npm
RUN mkdir -p /home/app/.nvm/
ENV XDG_CONFIG_HOME=/home/app/
ENV NVM_DIR $XDG_CONFIG_HOME.nvm
ENV NODE_VERSION 20.11.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH
RUN ln -sf $NVM_DIR/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm
RUN ln -sf $NVM_DIR/versions/node/v$NODE_VERSION/bin/node /usr/bin/node

EXPOSE 9000

COPY supervisord.conf /etc/supervisor/supervisord.conf

# Start script
COPY start.sh ./start.sh
RUN chmod +x ./start.sh
CMD ["./start.sh"]