ActiveAdmin.register Staff do
  menu if: proc { current_staff.admin? },
       label: 'スタッフ',
       priority: 101,
       parent: '管理用'


  permit_params :email, :password, :password_confirmation, :role

  index do
    selectable_column
    id_column
    column :role
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end

end
