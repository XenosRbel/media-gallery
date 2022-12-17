# frozen_string_literal: true

ActiveRecord::Schema.define(version: 2022_11_18_121947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"



  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "media_gallery_files", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "filesize", null: false
    t.integer "width", null: false
    t.integer "height", null: false
    t.integer "media_gallery_folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item"
    t.index ["media_gallery_folder_id"], name: "index_media_gallery_files_on_media_gallery_folder_id"
  end

  create_table "media_gallery_folders", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "system_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "media_gallery_files", "media_gallery_folders"
end
