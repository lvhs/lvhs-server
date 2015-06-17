class CreateEventSites < ActiveRecord::Migration
  def change
    create_table :event_sites do |t|
      t.string :name, null: false
      t.string :prefecture, null: false
      t.string :postal_code
      t.text :address
      t.string :phone

      t.timestamps null: false
    end

    add_index 'event_sites', ['name', 'prefecture'], unique: true
  end
end
