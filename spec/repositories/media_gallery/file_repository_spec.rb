# frozen_string_literal: true

require "rails_helper"

RSpec.describe MediaGallery::FileRepository, type: :repository do
  subject(:repository) { described_class.new(relation: relation) }

  let(:relation) { class_double(::MediaGallery::File) }

  describe "#create" do
    let(:attributes) { attributes_for(:media_gallery_file) }

    before { allow(relation).to receive(:create!).with(attributes) }

    it "checks whether folder with provided id exists" do
      repository.create(attributes)

      expect(relation).to have_received(:create!).with(attributes)
    end
  end

  describe "#exists_in_folder_by_name?" do
    let(:relation) { ::MediaGallery::File.all }
    let(:file_name) { FFaker::Lorem.word }
    let(:folder_id) { FFaker::Random.rand(1..100) }
    let(:result) { repository.exists_in_folder_by_name?(folder_id, file_name) }

    let(:expected_sql) do
      <<~SQL.squish
        SELECT 1 AS one FROM "media_gallery_files"
        WHERE "media_gallery_files"."name" = '#{file_name}'
        AND "media_gallery_files"."media_gallery_folder_id" = #{folder_id}
        LIMIT 1
      SQL
    end

    it "finds out if record with media gallery file name and folder_id exists" do
      expect { result }.to perform_sql_query(expected_sql)
    end
  end

  describe "#find_all_by_name" do
    let(:search_value) { "whatever" }
    let(:query) do
      hash_including(
        query: {
          match_phrase_prefix: {
            name: {
              query: search_value
            }
          }
        }
      )
    end

    let(:result) { repository.find_all_by_name(search_value) }

    before do
      allow(relation).to receive(:search).with(query)
    end

    it "returns search query response" do
      result
      expect(relation).to have_received(:search).with(query)
    end
  end

  describe "#find_by_ids" do
    let(:relation) { ::MediaGallery::File.all }
    let(:ids) { 2.times.map { FFaker::Random.rand(10) } }

    subject { repository.find_by_ids(ids).to_sql }

    let(:expected_sql) do
      <<~SQL.squish
        SELECT "media_gallery_files".*
        FROM "media_gallery_files"
        WHERE "media_gallery_files"."id" IN (#{ids.join(', ')})
      SQL
    end

    it { is_expected.to include(expected_sql) }
  end

  describe "#destroy_all_by_ids" do
    let(:relation) { ::MediaGallery::File.all }
    let(:ids) { 2.times.map { FFaker::Random.rand(1000) } }
    let(:filtered_by_ids_relation) { double(ActiveRecord::Relation) }
    let(:batched_relation) { double(ActiveRecord::Relation) }

    before do
      allow(relation).to receive(:where).and_return(filtered_by_ids_relation)
      allow(filtered_by_ids_relation).to receive(:in_batches).with(of: 100).and_return(batched_relation)
      allow(batched_relation).to receive(:destroy_all)
    end

    it "deletes files by ids", :aggregate_failures do
      repository.destroy_all_by_ids(ids)

      expect(relation).to have_received(:where).with(id: ids)
      expect(batched_relation).to have_received(:destroy_all)
    end
  end
end
