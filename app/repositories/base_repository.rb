# frozen_string_literal: true

class BaseRepository
  include DependencyInitializer

  def inspect
    "#<#{self.class.name} #{variables_metadata.join(' ')}>"
  end

  private

  def variables_metadata
    instance_variables.map do |variable|
      variable_name = variable.to_s[1..]
      variable_value = instance_variable_get(variable)
      variable_class = variable_value.respond_to?(:klass) ? variable_value.klass : variable_value.class

      ":#{variable_name}(#{variable_class.name})"
    end
  end
end
