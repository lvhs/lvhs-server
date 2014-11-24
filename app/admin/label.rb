ActiveAdmin.register Label do
  menu if: proc { current_staff.admin? },
       label: 'レーベル',
       priority: 100,
       parent: '管理用'

  permit_params :name

  index do
    selectable_column
    id_column
    column :name
  end
end
