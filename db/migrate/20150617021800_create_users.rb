class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :lead
      t.text :description
      t.integer :device_id, null: false
      t.string :image_path

      t.timestamps null: false
    end
    add_index 'users', ['device_id'], unique: true
  end
end
