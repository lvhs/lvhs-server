ActiveAdmin.register Label do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
  end
end
