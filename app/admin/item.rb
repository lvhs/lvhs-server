ActiveAdmin.register Item do
  menu label: '動画', priority: 11
  config.filters = false

  permit_params :artist_id, :name, :description, :media_type, :billing_method, :published_at, :status, :youtube_url
  #belongs_to :label

  index title: '動画一覧' do
    selectable_column
    id_column
    column 'タイトル', :name
    #column '説明文', :description
    column('アーティスト') { |item| item.artist.name }
    column '公開日時', :published_at
    column '有効期限', :finished_at
    column '状態' do |item|
      case item.status
      when :available
        if item.published_at > Time.now
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
      f.input :image_url, as: :file, label: 'ジャケット画像 *'
      f.input :youtube_url,
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
      item = params["item"]
      item["youtube_url"] = format_youtube_url(item["youtube_url"]) unless item["youtube_url"].blank?
      unless item["image_url"].blank?
        #DropboxApiClient.upload("artist/#{params[:artist_id]}/items/"
      # #<ActionDispatch::Http::UploadedFile:0x007f07a8dc5738 @tempfile=#<Tempfile:/tmp/RackMultipart20141130-22877-guu4mk>, @original_filename="IMG_1705_Fotor.png", @content_type="image/png", @headers="Content-Disposition: form-data; name=\"item[image_url]\"; filename=\"IMG_1705_Fotor.png\"\r\nContent-Type: image/png\r\n">
      end
      #throw 'hoge'
      puts create!
    end

    def format_youtube_url(url)
      if %r{youtube\.com/watch\?.*v=(?<id>[a-zA-Z0-1\-_]+)} =~ url
        id
      elsif %r{youtu\.be/(?<id>[a-zA-Z0-1\-_])} =~ url
        id
      else
        nil
      end
    end

  end
end
