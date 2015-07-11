class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :scheduled_at, null: false
      t.integer :event_site_id, null: false
      t.integer :artist_id, null: false

      t.timestamps null: false
    end

    add_index 'events', ['artist_id', 'event_site_id', 'scheduled_at'], unique: true
  end
end
