ActiveAdmin.register Artist do
  permit_params :label_id, :name, :key, :description
  #belongs_to :label

  index do
    selectable_column
    id_column
    column(:label) { |artist| artist.label.name }
    column :name
    column :key
    column :description
  end
end
