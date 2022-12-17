# frozen_string_literal: true

require "rails_helper"

RSpec.describe MediaGallery::FolderRepository, type: :repository do
  subject(:repository) { described_class.new(relation: relation) }

  let(:relation) { class_double(::MediaGallery::Folder) }

  describe "#create" do
    let(:attributes) { attributes_for(:media_gallery_folder) }

    before { allow(relation).to receive(:create!).with(attributes) }

    it "checks whether folder with provided id exists" do
      repository.create(attributes)

      expect(relation).to have_received(:create!).with(attributes)
    end
  end

  describe "#find_all" do
    let(:result) { repository.find_all }

    it "returns default relation" do
      expect(result).to eq(relation)
    end
  end

  describe "#exists_by_folder_id?" do
    let(:relation) { ::MediaGallery::Folder.all }
    let(:folder_id) { FFaker::Random.rand(100..999) }
    let(:result) { repository.exists_by_folder_id?(folder_id) }

    let(:expected_sql) do
      <<~SQL.squish
        SELECT 1 AS one FROM "media_gallery_folders"
        WHERE "media_gallery_folders"."id" = #{folder_id}
        LIMIT 1
      SQL
    end

    it "finds out if record with media gallery folder id exists" do
      expect { result }.to perform_sql_query(expected_sql)
    end
  end
end
