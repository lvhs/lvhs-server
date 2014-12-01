class RenameUrlColumn < ActiveRecord::Migration
  def change
    rename_column :artists, :image_url, :image_path
    rename_column :items, :image_url, :image_path
    rename_column :items, :youtube_url, :youtube_id
  end
end
