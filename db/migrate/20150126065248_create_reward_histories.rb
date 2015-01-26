class CreateRewardHistories < ActiveRecord::Migration
  def change
    create_table :reward_histories do |t|
      t.integer :device_id
      t.integer :cid
      t.string :cname
      t.integer :carrier
      t.datetime :click_date
      t.datetime :action_date
      t.integer :amount
      t.integer :commission
      t.string :aff_id
      t.integer :point
      t.integer :pid
      t.integer :item_id

      t.timestamps null: false

      # 広告ID × 会員ID × 成果発生日時 × 成果地点ID
    end
    add_index :reward_histories, [:cid, :device_id, :action_date, :pid], unique: true, name: 'conversion'
  end
end
