ActiveAdmin.register Artist do
  menu label: 'アーティスト', priority: 10
  #scope_to :label, unless: proc{ current_staff.admin? }
  scope_to :label, unless: proc { current_staff.admin? }

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
      if current_staff.label.nil?
        f.input :label, include_blank: false
      else
        f.input :label, value: current_staff.label_id, input_html: { disabled: true }
      end
      f.input :name
      f.input :key
      f.input :description
      f.input :official_url
      f.input :image_url, as: :file
    end
    f.actions
  end
end
