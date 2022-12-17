# frozen_string_literal: true

require_relative "./crud_controller/limited_access_action.rb"

RSpec.shared_examples_for :index_action_with_datatable do |template = "index"|
  let(:params) { {} }

  describe "GET index" do
    let(:send_request) { get :index, format: "html" }

    context "when format HTML" do
      it "renders template '#{template}'" do
        send_request

        expect(response).to render_template(template)
      end
    end

    context "when format JSON" do
      let(:json_datatable) { "json_datatable" }
      let(:send_request) { get :index, params: params.merge(format: "json") }

      before do
        allow(controller).to receive(:datatable_for).with(item_type, {}).and_return(json_datatable)

        send_request
      end

      it "returns datatable as json" do
        expect(response.body).to eq(json_datatable)
      end

      it "generates datatable with options" do
        expect(controller).to have_received(:datatable_for)
      end
    end

    it_behaves_like :limited_access_action do
      let(:successful_response) { respond_with(200) }
    end
  end
end
