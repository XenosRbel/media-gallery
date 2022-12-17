# frozen_string_literal: true

workers ENV.fetch("WEB_CONCURRENCY", 2).to_i

max_threads = ENV.fetch("PUMA_MAX_THREADS", 16).to_i
min_threads = ENV.fetch("PUMA_MIN_THREADS", max_threads).to_i
threads min_threads, max_threads

preload_app!
activate_control_app "tcp://127.0.0.1:9000", no_token: true
plugin :yabeda
plugin :yabeda_prometheus

puma_host = ENV["PUMA_HOST"]
puma_port = ENV.fetch("PORT", 3000).to_i

if puma_host && !puma_host.empty?
  bind "tcp://#{puma_host}:#{puma_port}"
else
  port puma_port
end

environment ENV["RACK_ENV"] || "development"

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end
