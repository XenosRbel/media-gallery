class AddItemToMediaGalleryFiles < ActiveRecord::Migration[5.0]
  def up
    add_column :media_gallery_files, :item, :string

    remove_column :media_gallery_files, :thumbnail_image
    remove_column :media_gallery_files, :original_image
    remove_column :media_gallery_files, :url
  end

  def down
    add_column :media_gallery_files, :thumbnail_image, :string, null: false, default: ''
    add_column :media_gallery_files, :original_image, :string, null: false, default: ''
    add_column :media_gallery_files, :url, :string,  null: false, default: ''

    remove_column :media_gallery_files, :item
  end
end
