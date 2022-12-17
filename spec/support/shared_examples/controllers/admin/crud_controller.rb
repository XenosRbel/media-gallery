# frozen_string_literal: true

require_relative "./crud_controller/create_action.rb"
require_relative "./crud_controller/destroy_action.rb"
require_relative "./crud_controller/edit_action.rb"
require_relative "./crud_controller/new_action.rb"
require_relative "./crud_controller/show_action.rb"
require_relative "./crud_controller/update_action.rb"
require_relative "./crud_controller/limited_access_action.rb"

RSpec.shared_examples_for :crud_controller do |actions|
  let(:param_key) { item_type.model_name.param_key }
  let(:valid_session) { {} }
  let(:default_params) { {} }
  let(:after_create_redirection) { nil }
  let(:after_update_redirection) { nil }
  let(:after_destroy_redirection) { nil }
  let(:item) { create_item }

  actions ||= %i[create destroy edit new update]
  actions.each do |action|
    it_behaves_like "#{action}_action".to_sym
  end
end
