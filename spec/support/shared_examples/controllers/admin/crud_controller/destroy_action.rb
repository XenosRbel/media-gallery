# frozen_string_literal: true

require_relative "./limited_access_action.rb"

RSpec.shared_examples_for :destroy_action do
  describe "DELETE destroy" do
    let!(:item) { create_item }
    let(:send_request) { delete :destroy, params: default_params.merge(id: item.to_param), session: valid_session }

    it "destroys the requested item" do
      expect { send_request }.to change(item_type, :count).by(-1)
    end

    it "redirects to the items list" do
      send_request
      expect(response).to redirect_to(after_destroy_redirection || index_path)
    end

    it_behaves_like :limited_access_action do
      let(:successful_response) { redirect_to(after_destroy_redirection || index_path) }
    end
  end
end
