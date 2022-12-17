# frozen_string_literal: true

require "rails_helper"

RSpec.describe MediaGallery::Folder, type: :model do
  describe "schema" do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:system_name).of_type(:string).with_options(null: false) }
  end

  describe "relations" do
    it do
      is_expected.to have_many(:files)
        .class_name("MediaGallery::File")
        .with_foreign_key(:media_gallery_folder_id)
    end
  end

  describe "validations" do
    %i[name system_name].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end

  describe "validates_format_of: :system_name" do
    it { is_expected.to allow_value(FFaker::Lorem.word.upcase).for(:system_name) }
    it { is_expected.to allow_value(FFaker::Lorem.word.downcase).for(:system_name) }
    it { is_expected.to allow_value(FFaker::Lorem.word.capitalize).for(:system_name) }
    it { is_expected.to_not allow_value(FFaker::LoremRU.word).for(:system_name) }
  end
end
