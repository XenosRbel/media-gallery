# frozen_string_literal: true

module ActiveRecord
  class Base
    cattr_accessor :skip_callbacks
  end
end
