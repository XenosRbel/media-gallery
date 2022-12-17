# frozen_string_literal: true

FactoryBot.define do
  factory :media_gallery_folder, class: MediaGallery::Folder do
    name { FFaker::LoremRU.word }
    system_name { FFaker::Lorem.word }

    trait :with_files do
      files { [association(:media_gallery_file)] }
    end
  end
end
