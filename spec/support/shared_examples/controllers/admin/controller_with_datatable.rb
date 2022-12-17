# frozen_string_literal: true

RSpec.shared_examples_for :controller_with_datatable do |shared_example_options = {}|
  let(:params) { {} }
  let(:action) { shared_example_options.fetch(:action, :index) }
  let(:serializer) { shared_example_options.fetch(:serializer) }
  let(:query_object_factory) { -> { query_object } }

  before do
    allow(controller.class).to receive(:serializer).and_return(serializer)
  end

  describe "GET index" do
    let(:user_for_authorization) { try(:current_user) || build(:admin_user, role: "admin") }
    let(:current_ability) { Abilities::Factory.build(user_for_authorization) }

    before do
      allow(controller).to receive_messages(action_name: action, current_ability: current_ability)
    end

    unless shared_example_options.fetch(:skip_html_format, false)
      context "when HTML format" do
        it "renders index template" do
          get :index, format: :html

          expect(response).to render_template(action)
        end
      end
    end

    context "when JSON format" do
      let(:datatable_params) do
        {
          page: "1",
          per_page: "15",
          sorted: [
            {
              id: "column",
              desc: false
            }.to_json
          ],
          filtered: [
            {
              id: "attribute",
              value: "value"
            }.to_json
          ]
        }
      end
      let(:records_for_serialization) { try(:records) || [] }
      let(:options) { try(:serializer_options) || {} }
      let(:serializer_instance) { instance_double(serializer) }
      let(:serialized_json) { "serialized_json" }
      let(:params) { super().merge(datatable_params) }

      let(:send_request) { get :index, params: params, format: :json }

      shared_examples_for :controller_with_datatable_index do
        before do
          allow(query_object).to receive(:call)
            .with(current_ability: current_ability, current_action: action, params: params)
            .and_return(records_for_serialization)
          allow(serializer).to receive(:new).with(records_for_serialization, options).and_return(serializer_instance)
          allow(serializer_instance).to receive(:serialized_json).and_return(serialized_json)
        end

        it "returns serialized json for datatable" do
          send_request

          expect(response.body).to eq(serialized_json)
        end

        context "when query raises Datatable::QueryError" do
          let(:status_code) { 400 }
          let(:reason) { "some reason" }
          let(:query_class) { query_object }
          let(:exception) do
            Admin::Datatable::QueryError.new(reason: reason, status_code: status_code, query_class: query_class)
          end
          let(:message) { "#{described_class.name}: #{exception.message}" }

          before do
            allow(controller).to receive(:serialized_json).and_raise(exception)
          end

          it "returns resonse with status code from exception" do
            send_request

            expect(response).to have_http_status(status_code)
          end

          it "logs exception message with ERROR level" do
            expect(Rails.logger).to receive(:error).with(message)

            send_request
          end
        end
      end

      context "when query object is instantiated lazily" do
        before do
          allow(controller.class).to receive(:query_object_factory).and_return(query_object_factory)
        end

        it_behaves_like :controller_with_datatable_index
      end

      context "when query object is instantiated eagerly" do
        before do
          allow(controller.class).to receive(:query_object_factory).and_return(nil)
          allow(controller.class).to receive(:query_object).and_return(query_object)
        end

        it_behaves_like :controller_with_datatable_index
      end
    end
  end
end
