# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::Folder::Destroyer, type: :service do
  subject(:service) {   described_class.new(contract: contract) }

  let(:contract) { instance_double(::MediaGallery::FolderContract) }

  describe "#call" do
    let(:service_call) { service.call(folder: folder_object) }

    before do
      allow(folder_object).to receive(:destroy).and_return(folder_object)
    end

    context "when object has no files and is valid" do
      let(:folder_object) { build_stubbed(:media_gallery_folder) }

      it "returns success result", :aggregate_failures do
        result = service_call

        expect(folder_object).to have_received(:destroy)
        expect(result.value).to eq(folder_object)
      end
    end

    context "when object has files and is valid" do
      let(:folder_object) { build_stubbed(:media_gallery_folder, :with_files) }

      let(:errors_hash) { { question: ["invalid"] } }
      let(:persistence_errors) { build(:media_gallery_folder_persistence_errors, **errors_hash) }

      before do
        allow(Admin::MediaGallery::Folder::PersistenceErrors).to receive(:new).and_return(persistence_errors)
      end

      it "fails with folder errors", :aggregate_failures do
        expect(folder_object).not_to have_received(:destroy)
        expect(service_call.failure).to eq(persistence_errors)
      end
    end

    context "when object has no files and is not valid" do
      let(:folder_object) { build_stubbed(:media_gallery_folder, name: "General", system_name: "General") }

      it "returns success result", :aggregate_failures do
        result = service_call

        expect(folder_object).to have_received(:destroy)
        expect(result.value).to eq(folder_object)
      end
    end

    context "when object has files and is not valid" do
      let(:folder_object) { build_stubbed(:media_gallery_folder, :with_files, name: "General", system_name: "General") }

      let(:errors_hash) { { question: ["invalid"] } }
      let(:persistence_errors) { build(:media_gallery_folder_persistence_errors, **errors_hash) }

      before do
        allow(Admin::MediaGallery::Folder::PersistenceErrors).to receive(:new).and_return(persistence_errors)
      end

      it "fails with folder errors", :aggregate_failures do
        expect(folder_object).not_to have_received(:destroy)
        expect(service_call.failure).to eq(persistence_errors)
      end
    end
  end
end
