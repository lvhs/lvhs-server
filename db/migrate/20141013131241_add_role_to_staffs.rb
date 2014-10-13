class AddRoleToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :role, :integer, null: false
  end
end
