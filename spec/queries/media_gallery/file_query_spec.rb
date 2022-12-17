# frozen_string_literal: true

require "rails_helper"

RSpec.describe MediaGallery::FileQuery, type: :query do
  subject(:query) { described_class.new(file_repository: file_repository) }

  let(:file_repository) { instance_double(::MediaGallery::FileRepository) }

  describe "#call" do
    let(:query_result) { query.call(params) }

    context "when passed name param" do
      let(:file) { build_stubbed(:media_gallery_file) }
      let(:file_ids) { [file.id] }
      let(:file_name) { file.name }
      let(:params) { { name: file_name } }

      let(:name_query_response) { instance_double(Elasticsearch::Model::Response::Response) }
      let(:name_query_results) { instance_double(Elasticsearch::Model::Response::Results) }
      let(:name_query_result_1) { double(Elasticsearch::Model::Response::Result) }

      before do
        allow(file_repository).to receive(:find_all_by_name).with(file_name).and_return(name_query_response)

        allow(name_query_response).to receive(:results).and_return(name_query_results)
        allow(name_query_result_1).to receive(:id).and_return(file.id)
        allow(name_query_results).to receive(:map)
          .and_yield(name_query_result_1).and_return(file_ids)
        allow(file_repository).to receive(:find_by_ids).with(file_ids).and_return(files)
      end

      let(:files) { build_stubbed_list(:media_gallery_file, 1) }

      it "finds by name param", :aggregate_failures do
        expect(query_result).to eq(files)
        expect(file_repository).to have_received(:find_all_by_name).with(file_name)
        expect(file_repository).to have_received(:find_by_ids).with(file_ids)
      end
    end

    context "when passsed file_ids param" do
      let(:file) { build_stubbed(:media_gallery_file) }
      let(:file_ids) { [file.id] }
      let(:params) { { file_ids: file_ids } }

      before do
        allow(file_repository).to receive(:find_by_ids).with(file_ids).and_return(files)
      end

      let(:files) { build_stubbed_list(:media_gallery_file, 1) }

      it "finds by name param", :aggregate_failures do
        expect(query_result).to eq(files)
        expect(file_repository).to have_received(:find_by_ids).with(file_ids)
      end
    end

    context "when passed empty params" do
      let(:params) { {} }

      before do
        allow(file_repository).to receive(:find_by_ids).with([]).and_return([])
      end

      it "returns empty query result" do
        expect(query_result).to eq([])
      end
    end
  end
end
