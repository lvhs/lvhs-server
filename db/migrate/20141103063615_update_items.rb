alass UpdateItems < ActiveRecord::Migration
  def change
    change_column :items, :artist_id, :integer, null: false
    change_column :items, :type, :integer, null: false
    change_column :items, :billing_method, :integer, null: false
  end
end
