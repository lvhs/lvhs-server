class AddSomeIdsToItems < ActiveRecord::Migration
  def change
    add_column :items, :vimeo_id, :string
    add_column :items, :apple_product_id, :string
  end
end
