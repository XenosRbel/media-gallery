# frozen_string_literal: true

class RedisMemoryStore < ActiveSupport::Cache::RedisCacheStore
  def initialize(*_args)
    config = ConfigReader.config_for(:redis_memory_store)
    super(config)
  end
end
