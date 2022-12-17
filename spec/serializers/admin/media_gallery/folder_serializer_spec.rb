# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::FolderSerializer, type: :serializer do
  subject(:serializer) { described_class.new(resource) }

  describe "#as_json" do
    let(:object) { build_stubbed(:media_gallery_folder) }
    let(:resource) { [object] }

    let(:type) { :media_gallery_folder }

    let(:object_hash) do
      [
        id: object.id,
        name: object.name,
        system_name: object.system_name,
        media_gallery_file_ids: object.file_ids
      ]
    end

    let(:result) { serializer.as_json }

    it "returns serialized resource" do
      expect(result).to eq(object_hash)
    end
  end
end
