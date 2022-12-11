class CreateMediaGalleryFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :media_gallery_files do |t|
      t.string :name, null: false
      t.text :description
      t.integer :filesize, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.string :original_image, null: false
      t.string :thumbnail_image, null: false
      t.string :url, null: false

      t.references :media_gallery_folder, foreign_key: true, index: true

      t.timestamps
    end
  end
end
