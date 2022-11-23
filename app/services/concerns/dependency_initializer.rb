# frozen_string_literal: true

module DependencyInitializer
  def self.included(base)
    base.extend Dry::Initializer
    base.extend ClassMethods
  end

  module ClassMethods
    def dependency(dependency_name, **options)
      option dependency_name, **options, reader: :private
    end
  end
end
