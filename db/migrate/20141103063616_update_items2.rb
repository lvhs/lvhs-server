class UpdateItems2 < ActiveRecord::Migration
  def change
    rename_column :items, :type, :media_type
  end
end
