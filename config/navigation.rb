# frozen_string_literal: true

SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = DefaultRenderer

  navigation.active_leaf_class = 'active'

  navigation.auto_highlight = true

  navigation.ignore_query_params_on_auto_highlight = true
  navigation.ignore_anchors_on_auto_highlight = true
end
