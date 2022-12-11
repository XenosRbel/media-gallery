# frozen_string_literal: true

module SerializeLinkHelper
  def define_links(*actions)
    actions.each do |action|
      link("#{action}_path".camelize(:lower).to_sym) do |object, params|
        params[:"#{action}_path_helper"].call(object)
      end
    end
  end
end
