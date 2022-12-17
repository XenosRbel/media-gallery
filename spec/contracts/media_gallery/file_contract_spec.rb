# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::MediaGallery::FileContract, type: :contract do
  subject(:contract) do
    described_class.new(folder_repository: folder_repository,
                        file_repository: file_repository,
                        file_name_sanitizer: file_name_sanitizer)
  end

  let(:folder_repository) { instance_double(::MediaGallery::FolderRepository) }
  let(:file_repository) { instance_double(::MediaGallery::FileRepository) }
  let(:file_name_sanitizer) { instance_double(::MediaGallery::FileNameSanitizer) }

  describe "#call" do
    let(:media_gallery_folder) { build_stubbed(:media_gallery_folder) }
    let(:actual_value) { contract.call(params) }
    let(:exists_by_file_name) { false }

    describe "media_gallery_folder_id" do
      let(:exists_by_folder_id) { true }
      let(:media_gallery_folder_id) { media_gallery_folder.id }
      let(:params) { { "media_gallery_folder_id" => media_gallery_folder_id } }

      before do
        allow(folder_repository).to receive(:exists_by_folder_id?).with(media_gallery_folder_id)
          .and_return(exists_by_folder_id)
      end

      context "when passed invalid media_gallery_folder_id param" do
        let(:media_gallery_folder_id) { nil }
        let(:params) { super().merge("media_gallery_folder_id" => media_gallery_folder_id) }

        it "is failed", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors[:media_gallery_folder_id]).to eq(["Не может быть пустым"])
        end
      end

      context "when invalid_media_gallery_folder_id is not integer" do
        let(:media_gallery_folder_id) { FFaker::LoremRU.word }
        let(:params) { super().merge("media_gallery_folder_id" => media_gallery_folder_id) }

        it "is fails with 'int?' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors[:media_gallery_folder_id]).to eq(["Не является числом"])
        end
      end

      context "when folder is not exist in repository" do
        let(:media_gallery_folder_id) { FFaker::Random.rand(0..9) }
        let(:params) { super().merge("media_gallery_folder_id" => media_gallery_folder_id) }
        let(:exists_by_folder_id) { false }

        it "is fails with 'int?' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors[:media_gallery_folder_id]).to eq(["Не найдено"])
        end
      end
    end

    describe "item" do
      context "when uploaded item is of type JSON" do
        let(:exists_by_folder_id) { true }
        let(:media_gallery_folder_id) { FFaker::Random.rand(0..9) }
        let(:content_type) { "application/json" }
        let(:file_path) { Rails.root.join("spec", "fixtures", "Json.json").to_s }
        let(:uploaded_file) { Rack::Test::UploadedFile.new(file_path, content_type, true) }
        let(:params) { { "item" => uploaded_file, "media_gallery_folder_id" => media_gallery_folder_id } }

        let(:sanitized_name) { FFaker::LoremRU.word }

        before do
          allow(file_name_sanitizer).to receive(:call).with(uploaded_file.original_filename).and_return(sanitized_name)
          allow(file_repository).to receive(:exists_in_folder_by_name?)
            .with(media_gallery_folder_id, sanitized_name).and_return(exists_by_file_name)
          allow(folder_repository).to receive(:exists_by_folder_id?).with(media_gallery_folder_id)
            .and_return(exists_by_folder_id)
        end

        it "is fails with 'invalid_format' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors.to_h[:item]).to eq(["Неверный формат файла"])
        end
      end

      context "when uploaded file has invalid type" do
        let(:params) { { "item" => FFaker::Random.rand } }

        it "is fails with 'type?' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors[:item]).to eq(["Неверный тип данных"])
        end
      end

      context "when uploaded file has nil" do
        let(:params) { { "item" => nil } }

        it "is fails with 'key?' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors[:item]).to eq(["Параметр отсутствует"])
        end
      end

      context "when uploaded file exists in system" do
        let(:exists_by_file_name) { true }
        let(:media_gallery_folder_id) { media_gallery_folder.id }
        let(:description) { FFaker::LoremRU.word }
        let(:content_type) { "video/mp4" }
        let(:file_path) { Rails.root.join("spec", "fixtures", "video.mp4").to_s }
        let(:uploaded_file) { Rack::Test::UploadedFile.new(file_path, content_type, true) }
        let(:params) do
          {
            "media_gallery_folder_id" => media_gallery_folder_id,
            "item" => uploaded_file,
            "description" => description
          }
        end
        let(:exists_by_folder_id) { true }
        let(:sanitized_name) { FFaker::LoremRU.word }

        before do
          allow(folder_repository).to receive(:exists_by_folder_id?).with(media_gallery_folder_id)
            .and_return(exists_by_folder_id)
          allow(file_name_sanitizer).to receive(:call).with(uploaded_file.original_filename).and_return(sanitized_name)
          allow(file_repository).to receive(:exists_in_folder_by_name?)
            .with(media_gallery_folder_id, sanitized_name).and_return(exists_by_file_name)
        end

        it "fails with 'key?' error", :aggregate_failures do
          expect(actual_value).to be_failure
          expect(actual_value.errors[:item]).to eq(["Операцию произвести невозможно. Наименование и расширение " \
                                                    "загружаемого файла video.mp4 совпадают с уже имеющимся"])
        end
      end
    end

    describe "all params" do
      let(:media_gallery_folder_id) { media_gallery_folder.id }
      let(:description) { FFaker::LoremRU.word }
      let(:content_type) { "video/mp4" }
      let(:file_path) { Rails.root.join("spec", "fixtures", "video.mp4").to_s }
      let(:uploaded_file) { Rack::Test::UploadedFile.new(file_path, content_type, true) }
      let(:params) do
        {
          "media_gallery_folder_id" => media_gallery_folder_id,
          "item" => uploaded_file,
          "description" => description
        }
      end
      let(:sanitized_name) { FFaker::LoremRU.word }

      before do
        allow(folder_repository).to receive(:exists_by_folder_id?).with(media_gallery_folder_id)
          .and_return(true)
        allow(file_name_sanitizer).to receive(:call).with(uploaded_file.original_filename).and_return(sanitized_name)
        allow(file_repository).to receive(:exists_in_folder_by_name?)
          .with(media_gallery_folder_id, sanitized_name).and_return(exists_by_file_name)
      end

      context "when passed the correct media_gallery_folder_id, item, and description" do
        it "is successful" do
          expect(actual_value).to be_success
        end
      end

      context "when description is empty" do
        let(:description) { "" }
        let(:params) { super().merge("description" => description) }

        it "is successful" do
          expect(actual_value).to be_success
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
