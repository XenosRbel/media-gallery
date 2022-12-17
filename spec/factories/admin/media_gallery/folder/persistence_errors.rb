# frozen_string_literal: true

FactoryBot.define do
  factory :media_gallery_folder_persistence_errors, class: Admin::MediaGallery::Folder::PersistenceErrors do
    skip_create
    initialize_with { new(**attributes) }
  end
end
