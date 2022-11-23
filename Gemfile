source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 7.0.4'

gem 'cssbundling-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'sassc-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

gem 'responders'

# Front JS Rendering
gem "react-rails"

# Database
gem 'activerecord-nulldb-adapter'
gem 'activerecord-postgres_enum'
gem 'activeresource'
gem 'pg'
gem 'redis'
gem 'redis-namespace'
gem 'seedbank'

# Background workers
gem 'after_party'

# Services
gem 'rest-client'

# File managing
gem 'carrierwave'
gem 'carrierwave-size-validator'
gem 'carrierwave-video-thumbnailer'
gem 'mime-types'
gem 'mini_magick'
gem 'piet'
gem 'streamio-ffmpeg'

# Parser
gem 'json-schema'

# Web Server
gem 'puma'

gem 'sassc'

gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Observability
gem 'prometheus-client-mmap'
gem 'yabeda'
gem 'yabeda-prometheus-mmap'
gem 'yabeda-puma-plugin'
gem 'yabeda-rails'

# Logging
gem 'lograge'

# Views
gem 'slim-rails'

# Configuration
gem 'dotenv-rails'

# Dry-rb stack
gem 'dry-core'
gem 'dry-struct'
gem 'dry-validation'

# Backend plugins
gem 'browser'
gem 'clowne'
gem 'enumerize'
gem 'mobile-fu'
gem 'rack-attack'
gem 'rack-cors'

# Localization
gem 'russian'

# API documentation
gem 'rswag-api'
gem 'rswag-ui'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'parallel_tests'
  gem 'rspec-rails'

  gem 'ffaker'

  # Preloader
  gem 'spring'
  gem 'spring-commands-rspec'

  # API documentation
  gem 'rswag-specs'
end

group :development do
  # Debugging
  gem 'better_errors'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rack-mini-profiler'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'ffaker'
  gem 'json_matchers'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers'
end
