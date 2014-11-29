class RenameLabelToArtistGroup < ActiveRecord::Migration
  def change
    rename_table :labels, :artist_groups
    rename_column :artists, :label_id, :artist_group_id
    rename_column :staffs, :label_id, :artist_group_id
  end
end
