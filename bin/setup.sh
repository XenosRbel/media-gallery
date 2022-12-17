#!/usr/bin/env sh

# exit on fail
set -e

echo '== Installing dependencies =='
bundle check || bundle install
yarn install

echo '== Create database =='
bundle exec rails db:create

echo '== Export i18n js translations =='
bundle exec rails i18n:js:export
