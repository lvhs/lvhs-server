class CreatePrefectures < ActiveRecord::Migration
  def change
    create_table :prefectures do |t|
      t.string :name

      t.timestamps null: false
    end

    add_index :prefectures, [:name], unique: true

    remove_index :event_sites, :name_and_prefecture
    remove_column :event_sites, :prefecture

    add_column :event_sites, :prefecture_id, :integer, null: false
    add_index :event_sites, [:name, :prefecture_id], unique: true
  end
end
