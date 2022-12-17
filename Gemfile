# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.7.3"

gem 'rails', '~> 5.2.6'
gem "rack", "~> 2.2.2"

# Database
gem "activerecord-nulldb-adapter", "~> 0.4.0"
gem "activeresource", "~> 5.1"
gem "pg", "~> 0.18.2"
gem "redis", "~> 4.1", ">= 4.1.3"
gem "redis-namespace", "~> 1.7"
gem "seedbank", "~> 0.3.0"
gem "activerecord-postgres_enum", "~> 1.6"
gem "activerecord-postgis-adapter", "~> 5.2.2"

# Background workers
gem "after_party", "~> 1.10.0"

# Views
gem "closure_tree", "~> 7.0.0"
gem "slim-rails", "~> 3.1.1"
gem "liquid", "~> 4.0"

# Search
gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: '7.2.0'
gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: '7.2.0'

# Services
gem "rails-settings-cached", "~> 0.6.5"

# File managing
gem "carrierwave", "~> 1.3", ">= 1.3.2"
gem "carrierwave-ftp", "~> 0.2.8", require: "carrierwave/storage/ftp"
gem "carrierwave-size-validator", "~> 0.1.0"
gem "carrierwave-video-thumbnailer", "~> 0.1.4"
gem "mini_magick", "~> 4.11.0"
gem "streamio-ffmpeg", "~> 3.0", ">= 3.0.2"
gem "piet", "~> 0.2.6"
gem "mime-types", "~> 3.3.1"

# Parser
gem "json-schema", "~> 2.8", ">= 2.8.1"

gem "fast_excel", "~> 0.4"
gem "zip-zip", "~> 0.3"
gem "parslet", "~> 2.0"

# Configuration
gem "dotenv-rails", "~> 2.7", ">= 2.7.5"

# Dry-rb stack
gem "dry-core", "~> 0.5.0"
gem "dry-struct", "~> 1.4.0"
gem "dry-validation", "~> 1.6.0"

# Backend plugins
gem "enumerize", "~> 2.3.1"
gem "browser", "~> 4.0.0"
gem "rack-attack", "~> 5.4"
gem "rack-cors", "~> 1.0.4"
gem "cancancan"

# Localization
gem "russian", "~> 0.6.0"

# API documentation
gem "rswag-api", "~> 2.2.0"
gem "rswag-ui", "~> 2.2.0"

# Assets
gem "breadcrumbs_on_rails", "~> 3.0.1"
gem "coffee-rails", "~> 4.2.2"
gem "font-awesome-rails", "~> 4.7", ">= 4.7.0.5"
gem "i18n-js", "~> 3.0.0.rc13"
gem "jquery-rails", "~> 4.4.0"
gem "sassc-rails", "~> 2.1.2"
gem "sprockets-rails", "~> 2.3.3"
gem "uglifier", ">= 3.2.0"

# Validators
gem "activerecord_json_validator", "~> 1.1.0"
gem "validates_timeliness", "~> 4.0"

# Front JS Rendering
gem "react-rails", "~> 2.4.7"
gem "webpacker", "~> 4.0", ">= 4.0.2"

gem "paranoia", "~> 2.4", ">= 2.4.2"
gem "request_store", "~> 1.1.0"

# Serializators
gem "jsonapi-serializer", "~> 2.2.0"
gem "oj"
gem "oj_mimic_json"

# Web Server
gem "puma", "~> 5.6.2"

# Observability
gem "yabeda", "~> 0.8.0"
gem "yabeda-rails", "~> 0.7.0"
gem "prometheus-client-mmap", "~> 0.12.0"
gem "yabeda-prometheus-mmap", "~> 0.1.1"
gem "yabeda-puma-plugin", "~> 0.4.0"

# Logging
gem "lograge", "~> 0.11.2"
gem "sidekiq-logging-json", "~> 0.0.19"

gem "responders"

group :development do
  # Debugging
  gem "better_errors"
  gem "binding_of_caller"
  gem "pry-byebug", "~> 3.9"
  gem "pry-doc", "~> 1.1"
  gem "pry-rails", "~> 0.3.9"
  gem "rack-mini-profiler", "~> 1.0.2"
  gem "benchmark-ips", "~> 2.8.3", require: false

  # Mailing
  gem "letter_opener", "~> 1.4.1"

  gem "rubocop", "~> 1", require: false
  gem "rubocop-rspec", "~> 2.4.0", require: false
  gem "scss_lint", ">= 0.59", require: false
  gem "slim_lint", "~> 0.21.1 ", require: false
  gem "undercover", "~> 0.3.4", require: false
end

group :development, :test do
  gem "parallel_tests", "~> 2.31"
  gem "rspec-rails", "~> 3.9"

  # Preloader
  gem "spring", "~> 2.0", ">= 2.0.2"
  gem "spring-commands-rspec", "~> 1.0", ">= 1.0.4"

  # API documentation
  gem "rswag-specs", "~> 2.2.0"
  gem "test-prof", "~> 0.12.2"
end

group :test do
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot_rails", "~> 5.1.1", require: false
  gem "ffaker", "~> 2.13.0"
  gem "json_matchers", "~> 0.11.0"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.4"
  gem "shoulda-matchers", "~> 4.1.2"
  gem "simplecov", "0.18.5", require: false
  gem "simplecov-lcov", "~> 0.8.0", require: false
  gem "timecop", "~> 0.9.1"
  gem "webmock", "~> 3.5", ">= 3.5.1"
  gem "timecop-rspec", "~> 1.0.0", git: "https://github.com/avantoss/timecop-rspec"
end
