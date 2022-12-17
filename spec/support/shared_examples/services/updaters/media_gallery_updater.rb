# frozen_string_literal: true

RSpec.shared_examples_for :media_gallery_updater do
  describe "#call" do
    let(:params) { { what: "ever" } }
    let(:contract_result) { instance_double(Dry::Validation::Result) }

    before do
      allow(contract).to receive(:call).and_return(contract_result)
      allow(contract_result).to receive(:success?).and_return(contract_result_success)
    end

    context "when params are valid" do
      let(:contract_result_success) { true }
      let(:contract_result_hash) { params }

      before do
        allow(contract_result).to receive(:to_h).and_return(contract_result_hash)
        allow(object).to receive(:update).with(contract_result_hash).and_return(object)
      end

      it "returns success result", :aggregate_failures do
        result = service_call
        expect(result.value).to eq(object)
        expect(object).to have_received(:update)
      end
    end

    context "when params are invalid" do
      let(:contract_result_success) { false }
      let(:errors) { instance_double(Dry::Validation::MessageSet) }

      before do
        allow(contract_result).to receive(:errors).and_return(errors)
        allow(errors).to receive(:to_h).and_return(errors_hash)
      end

      context "when result has validations errors" do
        let(:errors_hash) { { question: ["invalid"] } }

        before do
          allow(persistence_errors_class).to receive(:new).and_return(persistence_errors)
        end

        it "fails with group errors" do
          expect(service_call.failure).to eq(persistence_errors)
        end
      end
    end
  end
end
