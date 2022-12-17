# frozen_string_literal: true

require_relative "./limited_access_action.rb"

RSpec.shared_examples_for :new_action do
  describe "GET new" do
    let(:send_request) { get :new, params: default_params, session: valid_session }

    it "assigns a new item" do
      send_request
      expect(assigns(item_name)).to be_a_new(item_type)
    end

    it_behaves_like :limited_access_action do
      let(:successful_response) { respond_with(200) }
    end
  end
end
