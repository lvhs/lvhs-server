ActiveAdmin.register Item do
  menu label: '動画', priority: 11
  config.filters = false

  permit_params :artist_id, :name, :description, :media_type, :billing_method, :published_at, :status, :youtube_id, :image_path, :image_url
  #belongs_to :label

  after_save do |item|
    unless params[:item][:image].blank?
      image = params[:item][:image]
      /^image\/(?<ext>\w+)/ =~ image.content_type
      path = "artist/#{item.artist_id}/items/#{item.id}/cover.#{ext}"
      DropboxApiClient.upload(path, image.tempfile, overwrite: true)
      item.update_attributes! image_path: path
    end
  end

  index title: '動画一覧' do
    selectable_column
    #id_column
    column('編集') { |item| link_to "編集", admin_item_path(item) }
    column 'タイトル', :name
    #column '説明文', :description
    column('アーティスト') { |item| item.artist.nil? ? "" : item.artist.name }
    column '公開日時', :published_at
    column '有効期限', :finished_at
    column '状態' do |item|
      case item.status
      when "available"
        if item.published_at.nil?
          '公開'
        elsif item.published_at > Time.now
          '公開前'
        elsif item.finished_at <= Time.now
          '販売終了'
        else
          '公開'
        end
      else
        '非公開'
      end
    end
  end

  show title: '動画編集' do |item|
    panel item.name do
      div class: "attributes_table" do
        table for: item do
          tr class: "row" do
            th "アーティスト"
            td item.artist.name
          end
          tr class: "row" do
            th "課金方法"
            td item.billing_method == "free" ? "無料" : "有料"
          end
          tr class: "row" do
            th "作成日"
            td item.created_at
          end
          tr class: "row" do
            th "更新日"
            td item.updated_at
          end
          tr class: "row" do
            th "動画画像"
            td item.image_path.nil? ? "" : image_tag("https://dl.dropboxusercontent.com/u/19314247/lvhs/#{item.image_path}", height: "100%")
          end
          tr class: "row" do
            th "youtube"
            td link_to("https://www.youtube.com/watch?v=#{item.youtube_id}", "https://www.youtube.com/watch?v=#{item.youtube_id}")
          end
          tr class: "row" do
            th "公開設定"
            td item.status == "available" ? "公開中" : "非公開"
          end
          tr class: "row" do
            th "公開日"
            td item.published_at
          end
          tr class: "row" do
            th "配信終了日"
            td item.finished_at
          end
          tr class: "row" do
            th link_to("編集", edit_admin_item_path(item))
            td
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "動画情報を入力してください" do
      f.input :artist,
        collection: Artist.where(artist_group_id: current_staff.artist_group.id),
        label: 'アーティスト *',
        include_blank: false
      f.input :name, label: 'タイトル *'
      f.input :media_type, label: '&nbsp;', as: :radio, collection: [:video], value: :video, include_blank: false, disabled: true, input_html: { style: 'display: none;' }
      #f.input :media_type, as: :select, collection: %i(music video), include_blank: false
      #f.input :description, label: '説明文'
      f.input :billing_method, label: '課金方法 *', as: :radio, collection: { '無料' => :free, '有料' => :both  }
      #f.input :billing_method, as: :select, collection: %i(free in_app_purchase reward both), include_blank: false
      f.input :published_at, label: "公開日時 *", as: :just_datetime_picker
      f.input :finished_at, label: "有料販売 終了日時 *", as: :just_datetime_picker
      f.input :image, as: :file, label: 'ジャケット画像 *'
      f.input :youtube_id,
        placeholder: 'https://www.youtube.com/watch?v=v6kwUZQN7mU',
        label: 'youtube動画URL *'
      f.input :status, label: "公開設定 *", as: :radio, collection: { '公開' => :available, '非公開' => :unavailable }, default: :unavailable
    end
    f.actions
  end

  controller do
    def scoped_collection
      if current_staff.admin?
        Item.all
      else
        Item.artist(artist_group_id: current_staff.artist_group.id)
      end
    end

    def create
      item = params[:item]
      item[:youtube_id] = get_youtube_id(item[:youtube_id]) unless item[:youtube_id].blank?
      create!
    end

    def update
      item = params[:item]
      item[:youtube_id] = get_youtube_id(item[:youtube_id]) unless item[:youtube_id].blank?
      update!
    end

    def get_youtube_id(url)
      if %r{youtube\.com/watch\?.*v=(?<id>[a-zA-Z0-9\-_]+)} =~ url
        id
      elsif %r{youtu\.be/(?<id>[a-zA-Z0-9\-_]+)} =~ url
        id
      elsif %r{^[a-zA-Z0-9\-_]{11}$} =~ url
        url
      else
        nil
      end
    end

  end
end
