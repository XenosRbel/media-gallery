# frozen_string_literal: true

RSpec.shared_examples_for :remote_create_action do
  describe "POST create" do
    let(:entity_collection_path) { item_type.collection_path }
    let(:params) { { item_name => item.as_json } }

    let(:url) { item_type.site + entity_collection_path }
    let(:send_request) { post :create, params: params }

    context "with valid params" do
      before { stub_request(:post, url).to_return(body: item.to_json, status: 201) }

      it "assigns a newly created item" do
        send_request

        expect(assigns(item_name)).to be_a(item_type)
        expect(assigns(item_name)).to be_persisted
        expect(JSON.parse(response.body)["data"]).to match_json_schema(json_schema_path)
      end

      it "renders item JSON with resource path" do
        send_request

        link = JSON.parse(response.body, symbolize_names: true).dig(:data, :links, :resourcePath)

        expect(link).to eq(show_path_helper)
      end
    end

    context "with invalid params" do
      let(:item) { build_stubbed(factory_name, invalid_attribute) }

      it "assigns a newly created but unsaved item" do
        send_request

        expect(assigns(item_name)).to be_a_new(item_type)
      end

      it "renders json with errors" do
        send_request

        attributes = JSON.parse(response.body, symbolize_names: true).dig(:data, :attributes)
        expect(attributes).to have_key(:errors)
      end
    end
  end
end
