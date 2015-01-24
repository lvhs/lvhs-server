ActiveAdmin.register Artist, label: 'アーティスト' do
  menu label: 'アーティスト', priority: 10

  permit_params :artist_group_id, :name, :key, :description, :official_url, :status, :published_at, :image_url
  # belongs_to :label
  #
  after_save do |artist|
    unless params[:artist][:image].blank?
      image = params[:artist][:image]
      /^image\/(?<ext>\w+)/ =~ image.content_type
      path = "artist/#{artist.id}/jacket.#{ext}"
      #DropboxApiClient.upload(path, image.tempfile, overwrite: true)
      #artist.update_attributes! image_path: path
    end
  end

  index title: 'アーティスト一覧' do
    selectable_column
    # id_column
    column('編集') { |artist| link_to '編集', admin_artist_path(artist) }
    column('所属事務所') { |artist| artist.artist_group.name }
    column 'アーティスト名', :name
    column 'アーティストID(URL表示用)', :key
    # column '説明文', :description
  end

  show title: 'アーティスト編集' do |artist|
    panel artist.name do
      div class: 'attributes_table' do
        table for: artist do
          tr class: 'row' do
            th 'アーティストID(URL表示用)'
            td artist.key
          end
          tr class: 'row' do
            th 'オフィシャルサイトURL'
            td artist.official_url.blank? ? '' : link_to(artist.official_url, artist.official_url)
          end
          tr class: 'row' do
            th '所属事務所'
            td artist.artist_group.name
          end
          tr class: 'row' do
            th '作成日'
            td artist.created_at
          end
          tr class: 'row' do
            th '更新日'
            td artist.updated_at
          end
          tr class: 'row' do
            th 'アーティスト画像'
            td artist.image_path.nil? ? '' : image_tag("https://dl.dropboxusercontent.com/u/19314247/lvhs/#{artist.image_path}", height: '100%')
          end
          tr class: 'row' do
            th '公開設定'
            td artist.status == 'available' ? '公開中' : '非公開'
          end
          tr class: 'row' do
            th '公開日'
            td artist.published_at
          end
          tr class: 'row' do
            th link_to('編集', edit_admin_artist_path(artist))
            td
          end
        end
      end
    end
  end

  form title: 'アーティスト登録' do |f|
    f.inputs 'アーティスト情報を入力してください' do
      if current_staff.admin?
        f.input :artist_group, label: '所属事務所', include_blank: false
      else
        f.input :artist_group, label: '&nbsp;', value: current_staff.artist_group_id, input_html: { disabled: true, style: 'display: none;' }
      end
      f.input :name,
              placeholder: 'MyFirstStory',
              label: 'アーティスト名 *'
      f.input :key,
              placeholder: 'myfirststory',
              label: 'アーティストID(URL表示用) *',
              hint: '半角英数字(小文字)と記号(-_)を入力できます。(例:http://lvhs.jp/myfirststory)'
      # f.input :description, label: '説明文'
      f.input :official_url,
              placeholder: 'http://myfirststory.net',
              label: 'オフィシャルサイトURL'
      f.input :image, as: :file, label: 'アーティスト画像 *'
      f.input :status, label: '公開設定', as: :radio, collection: { '公開' => :available, '非公開' => :unavailable }, default: :unavailable
      f.input :published_at, label: '公開日', as: :just_datetime_picker
    end
    f.actions
  end

  controller do
    def scoped_collection
      if current_staff.admin?
        Artist.all
      else
        Artist.where(artist_group_id: current_staff.artist_group.id)
      end
    end
  end
end
