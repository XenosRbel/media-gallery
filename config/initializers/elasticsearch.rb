# frozen_string_literal: true

settings = ConfigReader.config_for(:elasticsearch)

Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: [settings.fetch(:host), settings.fetch(:port)].join(":"),
  retry_on_failure: settings.fetch(:max_retries_count),
  request_timeout: settings.fetch(:request_timeout),
  log: settings.fetch(:log_to_stdout)
)
