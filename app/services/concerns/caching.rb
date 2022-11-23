# frozen_string_literal: true

module Concerns
  module Caching
    private

    def with_cache(cache_key = cache_key_for_params, lifetime: api_lifetime)
      return yield unless cache_enabled?

      Rails.cache.fetch(cache_key, expires_in: lifetime) { yield }
    end

    def cache_key_for_params(cache_key_params = default_cache_key_params)
      cache_key_generator.call(controller_path, action_name, cache_key_params)
    end

    def default_cache_key_params
      params.permit!.to_h.except(:controller, :action)
    end

    def cache_enabled?
      cache_config.fetch(:enabled)
    end

    def api_lifetime
      cache_config.fetch(:lifetime)
    end

    def cache_config
      @cache_config ||= Openru::Config.fetch("cache.api")
    end

    def cache_key_generator
      @cache_key_generator ||= CacheKeyGenerator.new
    end
  end
end
