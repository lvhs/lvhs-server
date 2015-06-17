class CreateEventComments < ActiveRecord::Migration
  def change
    create_table :event_comments do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.text :comment, null: false
      t.string :image_path

      t.timestamps null: false
    end
  end
end
