# frozen_string_literal: true

RSpec.shared_examples_for :remote_crud_controller do |actions|
  before { allow(controller).to receive(:current_ability).with(no_args).and_return(ability) }

  actions ||= %i[create update destroy]
  actions.each do |action|
    it_behaves_like "remote_#{action}_action".to_sym
  end
end
