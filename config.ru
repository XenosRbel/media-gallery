# frozen_string_literal: true

require ::File.expand_path("../config/environment", __FILE__)
require "yabeda/prometheus/mmap"

use Yabeda::Prometheus::Exporter if Boolean(ENV.fetch("YABEDA_METRICS_ENABLED"))

run Rails.application
