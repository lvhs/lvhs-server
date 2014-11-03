class CreatePurchasedItems < ActiveRecord::Migration
  def change
    create_table :purchased_items do |t|
      t.string :key, unique: true
      t.integer :item_id, unique: true

      t.timestamps
    end
  end
end
