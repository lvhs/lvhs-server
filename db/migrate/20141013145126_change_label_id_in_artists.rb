class ChangeLabelIdInArtists < ActiveRecord::Migration
  def change
    change_column :artists, :label_id, :integer, null: false
  end
end
