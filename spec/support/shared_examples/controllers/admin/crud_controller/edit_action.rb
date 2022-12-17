# frozen_string_literal: true

require_relative "./limited_access_action.rb"

RSpec.shared_examples_for :edit_action do
  describe "GET edit" do
    let(:params) { default_params.merge(id: item.to_param) }
    let(:send_request) { get :edit, params: params, session: valid_session }

    it "assigns the requested item" do
      send_request
      expect(assigns(item_name)).to eq(item)
    end

    it_behaves_like :limited_access_action do
      let(:successful_response) { respond_with(200) }
    end
  end
end
