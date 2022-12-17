# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::File::Searcher, type: :service do
  subject(:service) { described_class.new(file_query: file_query) }

  let(:file_query) { instance_double(::MediaGallery::FileQuery) }

  let(:object) { build_stubbed(:media_gallery_file) }

  let(:file_ids) { [object.id] }
  let(:service_result) { service.call(params: search_params) }

  describe "#call" do
    before do
      allow(file_query).to receive(:call).and_return([object])
    end

    context "when search succeeded" do
      let(:search_params) { { name: object.name, file_ids: file_ids } }

      it "returns search result data" do
        expect(service_result.value.first).to eq(object)
      end
    end

    context "when search failed" do
      let(:search_params) { { name: "", file_ids: %w[a b c] } }

      let(:errors_hash) { { question: ["invalid"] } }
      let(:persistence_errors) { build(:media_gallery_file_search_errors, **errors_hash) }

      before do
        allow(Admin::MediaGallery::File::SearchErrors).to receive(:new).and_return(persistence_errors)
      end

      it "returns search errors" do
        expect(service_result.failure).to eq(persistence_errors)
      end
    end
  end
end
