class AddColumnToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :status, :integer, default: 0
    add_column :artists, :published_at, :datetime
    add_column :items, :status, :integer, default: 0
    add_column :items, :published_at, :datetime
    change_column :items, :billing_method, :integer, null: false, default: 3
    change_column :items, :media_type, :integer, null: false, default: 1
    change_column :items, :valid_for, :datetime
    rename_column :items, :valid_for, :finished_at
  end
end
