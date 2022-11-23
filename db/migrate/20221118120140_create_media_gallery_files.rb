class CreateMediaGalleryFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :media_gallery_files do |t|
      t.string :name
      t.text :description
      t.integer :filesize
      t.integer :width
      t.integer :height
      t.string :original_image
      t.string :thumbnail_image
      t.string :url

      t.references :media_gallery_folder, foreign_key: true, index: true

      t.timestamps
    end
  end
end
