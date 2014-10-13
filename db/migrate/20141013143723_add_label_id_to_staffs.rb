class AddLabelIdToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :label_id, :integer
  end
end
