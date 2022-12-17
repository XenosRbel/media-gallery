# frozen_string_literal: true

FactoryBot.define do
  factory :media_gallery_file, class: MediaGallery::File do
    name { FFaker::LoremRU.word }
    filesize { FFaker::Random.rand(10..2000) }
    width { FFaker::Random.rand(1000..2000) }
    height { FFaker::Random.rand(1000..2000) }
    description { FFaker::Lorem.sentence }
    media_gallery_folder_id { |file| file.folder&.id || 1 }
    item { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "1.jpg"), "image/jpeg") }

    association :folder, factory: :media_gallery_folder, strategy: :create

    trait :video do
      item { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "video.mp4"), "video/mp4") }
    end
  end
end
