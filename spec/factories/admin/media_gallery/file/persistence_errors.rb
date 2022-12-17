# frozen_string_literal: true

FactoryBot.define do
  factory :media_gallery_file_persistence_errors, class: Admin::MediaGallery::File::PersistenceErrors do
    skip_create
    initialize_with { new(**attributes) }
  end
end
