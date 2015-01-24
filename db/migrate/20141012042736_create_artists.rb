class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :key, unique: true
      t.text :description
      t.integer :label_id

      t.timestamps
    end
  end
end
