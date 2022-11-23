FROM ruby:3.1.2-slim-buster

ARG pg_major=12
ARG node_major=14
ARG node_version=14.15.0
ARG yarn_version=1.22.19

ENV APP_NAME /gallery

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl gnupg2 \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/debconf

# Set locale
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US:en

RUN apt-get update -qq \
    && apt-get install -qq -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/default/locale \
    && locale-gen

# add Yarn to the sources list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# add PostgreSQL to sources list
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ `awk -F= '$1=="VERSION_CODENAME" { print $2 ;}' /etc/os-release`-pgdg main" $pg_major > /etc/apt/sources.list.d/pgdg.list

# Minimal requirements to run a Rails app
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
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
      ssh && rm -rf /var/lib/apt/lists/*

RUN set -xe \
  && curl -o nodejs.deb https://deb.nodesource.com/node_$node_major.x/pool/main/n/nodejs/nodejs_$node_version-1nodesource1_amd64.deb \
  && dpkg -i ./nodejs.deb \
  && rm nodejs.deb \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/debconf

# configure bundler and PATH
ENV GEM_HOME=$APP_HOME/vendor/bundle
ENV BUNDLE_RETRY=3
ENV BUNDLE_PATH=$GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH
ENV BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH=$APP_HOME/bin:$BUNDLE_BIN:$PATH

RUN mkdir /$APP_NAME
WORKDIR /$APP_NAME

RUN   mkdir -p ~/.ssh
RUN   chmod 0600 -R ~/.ssh && \
      echo "StrictHostKeyChecking no " > ~/.ssh/config

COPY Gemfile* $APP_NAME/

ARG bundler_version=2.3.1
RUN set -xe \
  && gem install bundler:$bundler_version \
  && bundle install --jobs "$(getconf _NPROCESSORS_ONLN)" \
    --without development test \
  && rm -rf vendor/bundle/cache/*.gem \
  && find vendor/bundle/gems/ \
    -type f -name "*.c" -o -name "*.o" | xargs rm -f \
  && find vendor/bundle/extensions \
      -type f -name "mkmf.log" -o -name "gem_make.out" | xargs rm -f \
  && find vendor/bundle/gems -maxdepth 2 \
      \( -type d -name "spec" -o -name "test" -o -name "docs" \) -o \
        \( -name "*LICENSE*" -o -name "README*" -o -name "CHANGELOG*" \
            -o -name "*.md" -o -name "*.txt" -o -name ".gitignore" -o -name ".travis.yml" \
            -o -name ".rubocop.yml" -o -name ".yardopts" -o -name ".rspec" \
            -o -name "appveyor.yml" -o -name "COPYING" -o -name "SECURITY" \
            -o -name "HISTORY" -o -name "CODE_OF_CONDUCT" -o -name "CONTRIBUTING" \
        \) | xargs rm -rf

COPY package.json yarn.lock $APP_HOME/

RUN yarn install --frozen-lockfile --production --prefer-offline

ARG node_max_old_space_size=4096
ENV NODE_OPTIONS="--max-old-space-size=${node_max_old_space_size}"
ENV DATABASE_ADAPTER=nulldb

ENV RAILS_ENV=development
ENV REQUIRE_MASTER_KEY=false
ENV SECRET_KEY_BASE=not_secret
RUN set -xe \
  && bundle exec rails i18n:js:export \
  && bundle exec rails assets:precompile

# remove folders not needed in resulting image
RUN rm -rf \
  node_modules \
  tmp/cache \
  app/javascript/src/front/images

COPY . /$APP_NAME
