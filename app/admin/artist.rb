ActiveAdmin.register Artist do
  permit_params :label_id, :name, :key, :description, :official_url
  #belongs_to :label

  index do
    selectable_column
    id_column
    column(:label) { |artist| artist.label.name }
    column :name
    column :key
    column :description
  end

  form do |f|
    f.inputs "アーティスト情報を入力してください" do
      f.input :label, include_blank: false
      f.input :name
      f.input :key
      f.input :description
      f.input :official_url
      f.input :image_url, as: :file
    end
    f.actions
  end
end
