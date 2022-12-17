# frozen_string_literal: true

require_relative "./crud_controller/limited_access_action.rb"

RSpec.shared_examples_for :promo_controller do
  let(:valid_session) { {} }

  describe "POST set_promo" do
    let!(:product) { create_item }
    let(:toggle_promo_request) { post :toggle_promo, params: { id: product.id }, session: valid_session }

    it "sets product item as promo" do
      toggle_promo_request
      product.reload
      expect(assigns(:product)).to eq(product)
      expect(product).to be_promo
    end

    context "when product is promo" do
      let!(:product) { create(item_name, promo: true) }

      it "removes promo flag" do
        toggle_promo_request
        product.reload
        expect(product).not_to be_promo
      end
    end

    it_behaves_like :limited_access_action do
      let(:send_request) { toggle_promo_request }
      let(:successful_response) { redirect_to(index_path) }
    end
  end
end
