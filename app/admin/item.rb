ActiveAdmin.register Item do
  permit_params :artist_id, :name, :description, :media_type, :billing_method
  #belongs_to :label

  index do
    selectable_column
    id_column
    column :name
    column :media_type
    column :description
    column(:artist) { |item| item.artist.name }
    column :valid_for
  end

  form do |f|
    f.inputs "楽曲を入力してください" do
      f.input :artist, include_blank: false
      f.input :name
      f.input :media_type, as: :select, collection: %i(music video), include_blank: false
      f.input :description
      f.input :billing_method, as: :select, collection: %i(free in_app_purchase reward both), include_blank: false
      f.input :image_url, as: :file
      f.input :youtube_url
    end
    f.actions
  end
end
