ActiveAdmin.register ArtistGroup do
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

  form do |f|
    f.inputs '' do
      f.input :name
    end
    f.actions
  end
end
