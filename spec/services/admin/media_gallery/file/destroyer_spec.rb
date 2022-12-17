# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::File::Destroyer, type: :service do
  subject(:service) { described_class.new }

  let(:service_result) { service.call(params: params) }

  describe "#call" do
    context "when passed valid ids param" do
      let(:ids) { 2.times.map { FFaker::Random.rand(1000).to_s } }
      let(:params) { { ids: ids } }

      it "return destroyer result data" do
        result = service_result

        expect(result.value).to eq(true)
      end
    end

    context "when passed valid id param" do
      let(:id) { FFaker::Random.rand(1000).to_s }
      let(:params) { { id: id } }

      it "return destroyer result data" do
        result = service_result

        expect(result.value).to eq(true)
      end
    end

    context "when passed invalid ids param" do
      let(:ids) { 2.times.map { FFaker::Lorem.word } }
      let(:params) { { ids: ids } }

      let(:errors_hash) { { question: ["invalid"] } }
      let(:persistence_errors) { build(:media_gallery_file_persistence_errors, **errors_hash) }

      before do
        allow(Admin::MediaGallery::File::PersistenceErrors).to receive(:new).and_return(persistence_errors)
      end

      it "returns destroyer errors" do
        expect(service_result.failure).to eq(persistence_errors)
      end
    end

    context "when passed invalid id param" do
      let(:id) { FFaker::Lorem.word }
      let(:params) { { id: id } }

      let(:errors_hash) { { question: ["invalid"] } }
      let(:persistence_errors) { build(:media_gallery_file_persistence_errors, **errors_hash) }

      before do
        allow(Admin::MediaGallery::File::PersistenceErrors).to receive(:new).and_return(persistence_errors)
      end

      it "returns destroyer errors" do
        expect(service_result.failure).to eq(persistence_errors)
      end
    end
  end
end
