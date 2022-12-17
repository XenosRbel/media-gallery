# frozen_string_literal: true

FactoryBot.define do
  factory :media_gallery_file_search_errors, class: Admin::MediaGallery::File::SearchErrors do
    skip_create
    initialize_with { new(**attributes) }
  end
end
