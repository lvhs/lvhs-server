class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :key, unique: true, null: false

      t.timestamps
    end
  end
end
