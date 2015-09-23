class CreateVimeoQueues < ActiveRecord::Migration
  def change
    create_table :vimeo_queues do |t|
      t.integer :artist_id, null: false
      t.string :title
      t.integer :vimeo_id
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end

    add_index :vimeo_queues, [:artist_id, :vimeo_id], unique: true
  end
end
