# frozen_string_literal: true

require "yabeda/rails"

Yabeda::Rails.install! if Boolean(ENV.fetch("YABEDA_METRICS_ENABLED"))
