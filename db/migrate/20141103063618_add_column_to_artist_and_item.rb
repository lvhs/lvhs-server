class AddColumnToArtistAndItem < ActiveRecord::Migration
  def change
    add_column :artists, :image_url, :string
    add_column :items, :image_url, :string
    add_column :items, :youtube_url, :string
  end
end
