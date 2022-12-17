# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::File::SearchResult, type: :model do
  subject(:result) { described_class.new(params) }

  describe "#success?" do
    let(:search_errors) { Admin::MediaGallery::File::SearchErrors.new }

    context "when params contain value with valid file instance" do
      let(:file) { ::MediaGallery::File.new }
      let(:files_array) { [file] }
      let(:params) { { value: files_array } }

      it "returns success result" do
        expect(result).to be_success
      end

      context "when failure is not blank" do
        let(:params) { { value: files_array, failure: search_errors } }

        it "returns failure result" do
          expect(result).to be_failure
        end
      end
    end

    context "when params contain failure" do
      let(:params) { { failure: search_errors } }

      it "returns failure result" do
        expect(result).to be_failure
      end
    end
  end
end
