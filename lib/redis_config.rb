# frozen_string_literal: true

class RedisConfig
  def initialize
    @settings = ConfigReader.config_for(:redis).fetch(:main)
  end

  def url
    "redis://#{user}#{settings[:host]}:#{settings[:port]}/#{settings[:db]}"
  end

  def namespace
    settings[:namespace]
  end

  private

  attr_reader :settings

  def user
    if settings[:user].present? && settings[:password].present?
      "#{settings[:user]}:#{settings[:password]}@"
    else
      ""
    end
  end
end
