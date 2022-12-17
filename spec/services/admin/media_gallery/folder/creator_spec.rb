# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::Folder::Creator, type: :service do
  subject(:service) {   described_class.new(contract: contract, folder_repository: folder_repository) }

  let(:contract) { instance_double(::MediaGallery::FolderContract) }
  let(:folder_repository) { instance_double(::MediaGallery::FolderRepository) }

  describe "#call" do
    let(:service_call) { service.call(folder_params: folder_params) }
    let(:folder_params) { { what: "ever" } }
    let(:contract_result) { instance_double(Dry::Validation::Result) }

    before do
      allow(contract).to receive(:call).and_return(contract_result)
      allow(contract_result).to receive(:success?).and_return(contract_result_success)
    end

    context "when params are valid" do
      let(:contract_result_success) { true }
      let(:folder) { build_stubbed(:media_gallery_folder) }
      let(:contract_result_hash) { folder.attributes }

      before do
        allow(contract_result).to receive(:to_h).and_return(contract_result_hash)
        allow(folder_repository).to receive(:create).with(contract_result_hash).and_return(folder)
      end

      it "returns success result", :aggregate_failures do
        result = service_call

        expect(folder_repository).to have_received(:create).with(contract_result_hash)
        expect(result.value).to eq(folder)
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
        let(:persistence_errors) { build(:media_gallery_folder_persistence_errors, **errors_hash) }

        before do
          allow(Admin::MediaGallery::Folder::PersistenceErrors).to receive(:new).and_return(persistence_errors)
        end

        it "fails with folder errors", :aggregate_failures do
          expect(service_call.failure).to eq(persistence_errors)
        end
      end
    end
  end
end
