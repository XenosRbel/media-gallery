# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::FolderListSerializer, type: :serializer do
  subject(:serializer) { described_class.new(resource, options) }

  describe "#serializable_hash" do
    let(:object) { build_stubbed(:media_gallery_folder) }
    let(:resource) { [object] }
    let(:options) { { is_collection: true, params: params } }

    let(:serializer_options) do
      {
        is_collection: true,
        params: {
          folder_path_helper: method(:media_gallery_folder_path)
        }
      }
    end
    let(:params) { { folder_path_helper: media_gallery_folder_path } }
    let(:links) { { folderPath: FFaker::Internet.http_url } }
    let(:type) { :media_gallery_folder }
    let(:media_gallery_folder_path) { double("media_gallery_folder_path") }

    let(:object_hash) do
      {
        data: [
          {
            id: object.id.to_s,
            type: type,
            attributes: {
              id: object.id,
              name: object.name,
              system_name: object.system_name,
              media_gallery_file_ids: object.file_ids,
              files: []
            },
            links: links
          }
        ]
      }
    end

    before do
      allow(media_gallery_folder_path).to receive(:call).with(object).and_return(links[:folderPath])
    end

    let(:result) { serializer.serializable_hash }

    it "returns serialized resource", :aggregate_failures do
      expect(result).to match_json_schema("admin/media_gallery/items")
      expect(result).to eq(object_hash)
    end

    context "when folder has files" do
      let(:object) { build_stubbed(:media_gallery_folder, :with_files) }
      let(:file) { object.files.first }

      let(:file_hash) do
        {
          id: file.id,
          name: file.name,
          filesize: file.filesize,
          width: file.width,
          height: file.height,
          description: file.description,
          url: file.url,
          folder_id: file.media_gallery_folder_id,
          original_image: file.item.original_image_version.url,
          thumbnail_image: file.item.thumb.url,
          folder_name: file.folder.name
        }
      end

      let(:object_hash) do
        {
          data: [
            {
              id: object.id.to_s,
              type: type,
              attributes: {
                id: object.id,
                name: object.name,
                system_name: object.system_name,
                media_gallery_file_ids: object.file_ids,
                files: [file_hash]
              },
              links: links
            }
          ]
        }
      end

      it "returns serialized resource", :aggregate_failures do
        expect(result).to match_json_schema("admin/media_gallery/items")
        expect(result).to eq(object_hash)
      end
    end
  end
end
