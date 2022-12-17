# frozen_string_literal: true

RSpec.shared_examples_for :remote_destroy_action do
  describe "DELETE destroy" do
    let(:url) { item_type.site + item_type.element_path(item.id) }
    let(:send_request) { delete :destroy, params: { id: item.id } }

    before do
      stub_request(:get, url).to_return(body: item.to_json)
      stub_request(:delete, url).to_return(status: 200)
    end

    it "redirects to the correct path" do
      send_request

      expect(response).to redirect_to(redirect_path)
    end
  end
end
