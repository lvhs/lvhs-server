class UpdateArtist < ActiveRecord::Migration
  def change
    add_column :artists, :official_url, :string
  end
end
