# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::MediaGallery::UpdaterFileContract, type: :contract do
  subject(:contract) { described_class.new }

  describe "#call" do
    let(:media_gallery_file) { build_stubbed(:media_gallery_file) }
    let(:actual_value) { contract.call(params, file: media_gallery_file) }

    context "when passed the correct description and item" do
      let(:description) { FFaker::LoremRU.word }
      let(:content_type) { "image/jpeg" }
      let(:file_path) { Rails.root.join("spec", "fixtures", "1.jpg").to_s }
      let(:uploaded_file) { Rack::Test::UploadedFile.new(file_path, content_type, true) }
      let(:params) { { "description" => description, "item" => uploaded_file } }

      it "is successful" do
        expect(actual_value).to be_success
      end
    end

    context "when description is empty and missing file item" do
      let(:description) { "" }
      let(:params) { { "description" => description } }

      it "is successful" do
        expect(actual_value).to be_success
      end
    end

    describe "item" do
      context "when uploaded item is unsupported content type" do
        let(:content_type) { "application/json" }
        let(:file_path) { Rails.root.join("spec", "fixtures", "Json.json").to_s }
        let(:uploaded_file) { Rack::Test::UploadedFile.new(file_path, content_type, true) }
        let(:params) { { "item" => uploaded_file } }

        it "is fails with 'invalid_format' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors.to_h[:item]).to match_array(["Неверный формат файла", "Несовпадение форматов"])
        end
      end

      context "when uploaded file has invalid type" do
        let(:params) { { "item" => FFaker::Random.rand } }

        it "is fails with 'type?' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors[:item]).to eq(["Неверный тип данных"])
        end
      end
    end

    describe "description" do
      context "when value is not string" do
        let(:description) { FFaker::Random.rand }
        let(:params) { { "description" => description } }

        it "is fails with 'string?' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors[:description]).to eq(["Не является строкой"])
        end
      end
    end
  end
end
