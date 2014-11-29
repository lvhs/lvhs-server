class RenameLabelToArtistGroup < ActiveRecord::Migration
  def change
    rename_table :labels, :artist_groups
  end
end
