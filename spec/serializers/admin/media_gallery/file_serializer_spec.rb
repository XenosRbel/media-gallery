# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::FileSerializer, type: :serializer do
  subject(:serializer) { described_class.new(resource) }

  describe "#as_json" do
    let(:object) { build_stubbed(:media_gallery_file) }
    let(:resource) { [object] }

    let(:type) { :media_gallery_file }

    let(:object_hash) do
      {
        id: object.id,
        name: object.name,
        filesize: object.filesize,
        width: object.width,
        height: object.height,
        description: object.description.to_s,
        url: object.url,
        folder_id: object.folder.id,
        original_image: object.item.original_image_version.url,
        thumbnail_image: object.item.thumb.url,
        folder_name: object.folder.name
      }
    end

    let(:objects_hash_list) { [object_hash] }

    let(:result) { serializer.as_json }

    it "returns serialized resource" do
      expect(result).to eq(objects_hash_list)
    end
  end
end
