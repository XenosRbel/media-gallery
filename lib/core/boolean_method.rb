# frozen_string_literal: true

def Boolean(value) # rubocop:disable Naming/MethodName
  return true if value == true || value =~ /(true|t|yes|y|1)$/i
  return false if value.blank? || value =~ /(false|f|no|n|0)$/i

  raise ArgumentError, "Invalid value for Boolean: \"#{value}\""
end
