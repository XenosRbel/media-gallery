FROM ruby:2.7.3-slim-buster@sha256:22c57587b84b04f61efd03e8558d4c7ef50d0aed26c21531a68b8c7731c5efcf

ARG pg_major=13
ARG node_major=10
ARG node_version=10.23.2
ARG yarn_version=1.16.0

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl gnupg2 ca-certificates \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/debconf

# add PostgreSQL to sources list
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ `awk -F= '$1=="VERSION_CODENAME" { print $2 ;}' /etc/os-release`-pgdg main" $pg_major > /etc/apt/sources.list.d/pgdg.list

# add Yarn to the sources list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential \
      locales \
      git \
      openssh-client \
      imagemagick \
      optipng \
      jpegoptim \
      libgraphicsmagick-q16-3 \
      libpq-dev \
      postgresql-client-$pg_major \
      libxml2-dev \
      cmake \
      pkg-config \
      zip \
      unzip \
      file\
      tzdata \
      ffmpegthumbnailer \
      ffmpeg \
      yarn=$yarn_version-1 \
      python-minimal \
  && curl -o nodejs.deb https://deb.nodesource.com/node_$node_major.x/pool/main/n/nodejs/nodejs_$node_version-1nodesource1_amd64.deb \
  && dpkg -i ./nodejs.deb \
  && rm nodejs.deb \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/debconf

ENV APP_HOME /app

# add as ARG to support changing all BUNDLE_* variables via arg parameter
# in docker-compose.development.yml
ARG gem_home=$APP_HOME/vendor/bundle

# configure bundler and PATH
ENV GEM_HOME=$gem_home
ENV BUNDLE_JOBS=4
ENV BUNDLE_RETRY=3
ENV BUNDLE_PATH=$GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH
ENV BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH=$APP_HOME/bin:$BUNDLE_BIN:$PATH
ENV TZ='Europe/Minsk'

ARG bundler_version=2.3.1

# install required Bundler version
RUN gem install bundler:$bundler_version

# generate ru_RU.UTF-8 and en_US.UTF-8
RUN localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8 \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# configure timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone

ENV LANG=ru_RU.UTF-8

WORKDIR $APP_HOME
