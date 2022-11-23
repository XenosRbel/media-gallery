class CreateMediaGalleryFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :media_gallery_folders do |t|
      t.string :name
      t.string :system_name

      t.timestamps
    end
  end
end
