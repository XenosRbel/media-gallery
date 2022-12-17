class CreateMediaGalleryFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :media_gallery_folders do |t|
      t.string :name, null: false
      t.string :system_name, null: false

      t.timestamps
    end
  end
end
