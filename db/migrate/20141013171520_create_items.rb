class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :type
      t.text :description
      t.integer :artist_id
      t.integer :price
      t.integer :billing_method
      t.date :valid_for

      t.timestamps
    end
  end
end
