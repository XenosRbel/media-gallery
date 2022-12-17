# frozen_string_literal: true

require_relative "./limited_access_action.rb"

RSpec.shared_examples_for :update_action do
  let(:item) { create_item }
  let(:params) { default_params.merge(id: item.to_param, param_key => updated_attributes) }

  before { put :update, params: params, session: valid_session }

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested item" do
        item.reload
        updated_attributes.reject { |attr| attr =~ /_attributes/ } # skipping nested_form attributes
          .each do |attribute, value|
          expect(item[attribute]).to eq(if item_type.columns_hash[attribute.to_s].type == :json
                                          JSON.parse(value)
                                        else
                                          value
                                        end)
        end
      end

      it "assigns the requested item" do
        expect(assigns(item_name)).to eq(item)
      end

      it "redirects to the item" do
        expect(response).to redirect_to(after_update_redirection || index_path)
      end
    end

    describe "with invalid params" do
      let(:params) { default_params.merge(id: item.to_param, param_key => invalid_attributes) }

      it "assigns the item" do
        expect(assigns(item_name)).to eq(item)
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("edit")
      end
    end

    it_behaves_like :limited_access_action do
      let(:send_request) { put :update, params: params, session: valid_session }
      let(:successful_response) { redirect_to(after_update_redirection || index_path) }
    end
  end
end
