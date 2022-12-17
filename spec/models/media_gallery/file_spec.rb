# frozen_string_literal: true

require "rails_helper"

RSpec.describe MediaGallery::File, type: :model do
  describe "schema" do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:filesize).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:width).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:height).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:item).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }

    it { is_expected.to have_db_index(:media_gallery_folder_id) }
  end

  describe "relations" do
    it do
      is_expected.to belong_to(:folder)
        .class_name("MediaGallery::Folder")
        .with_foreign_key(:media_gallery_folder_id)
    end
  end

  describe "validations" do
    %i[name item].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end

    %i[filesize width height].each do |attribute|
      it { is_expected.to validate_numericality_of(attribute).only_integer }
    end
  end
end
