# frozen_string_literal: true

RSpec.shared_examples_for :remote_update_action do
  describe "PUT update" do
    let(:entity_element_path) { item_type.element_path(item.id) }

    let(:url) { item_type.site + entity_element_path }
    let(:updated_item) { item.as_json.merge(updated_attribute) }
    let(:updated_attribute) { { updated_attribute_name => updated_attribute_value } }
    let(:params) { { id: item.id, "#{item_name}": updated_attribute } }
    let(:send_request) { put :update, params: params, format: request_format }
    let(:request_format) { :html }

    before { stub_request(:get, url).to_return(body: item.to_json) }

    context "with valid params" do
      before { stub_request(:put, url).to_return(body: updated_item.to_json, status: 200) }

      context "when format is HTML" do
        it "redirects to the item path" do
          send_request

          expect(response).to redirect_to(show_path_helper)
        end
      end

      context "when format is JSON" do
        let(:request_format) { :json }

        it "responds with valid JSON" do
          send_request

          expect(JSON.parse(response.body)["data"]).to match_json_schema(json_schema_path)
        end

        it "responds with status: :ok" do
          send_request

          expect(response).to have_http_status(:ok)
        end
      end

      it "updates the requested item" do
        send_request

        expect(updated_item[updated_attribute_name]).to eq(updated_attribute_value)
      end

      it "assigns the requested item" do
        send_request

        expect(assigns(item_name)).to be_a(item_type)
      end
    end

    context "with invalid params" do
      let(:updated_attribute) { invalid_attribute }

      before { stub_request(:put, url).to_return(body: item.to_json, status: 422) }

      it "assigns the requested item" do
        send_request

        expect(assigns(item_name)).to be_a(item_type)
      end

      it "renders json with errors" do
        send_request

        attributes = JSON.parse(response.body, symbolize_names: true).dig(:data, :attributes)
        expect(attributes).to have_key(:errors)
      end
    end
  end
end
