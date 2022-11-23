# frozen_string_literal: true

module Concerns
  module Translatable
    private

    def translation_scope
      raise NotImplementedError, "implement #translation_scope in the subclass"
    end

    def translate_token(value, scope: translation_scope, args: {})
      I18n.t(value, { scope: scope }.merge(args))
    end

    def translate_token_regexp(value, scope: translation_scope)
      make_token_regexp(translate_token(value, scope: scope))
    end

    def make_token_regexp(value)
      Regexp.new(value, Regexp::IGNORECASE)
    end
  end
end
