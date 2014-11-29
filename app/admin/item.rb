ActiveAdmin.register Item do
  menu label: '楽曲', priority: 11

  scope_to :label, unless: proc { current_staff.admin? }

  permit_params :artist_id, :name, :description, :media_type, :billing_method
  #belongs_to :label

  index title: '楽曲一覧' do
    selectable_column
    id_column
    column 'タイトル', :name
    column '説明文', :description
    column('アーティスト') { |item| item.artist.name }
    column '有効期限', :valid_for
  end

  form do |f|
    f.inputs "楽曲情報を入力してください" do
      f.input :artist,
        label: 'アーティスト',
        include_blank: false
      f.input :name, label: 'タイトル'
      f.input :media_type, label: '&nbsp;', value: :video, include_blank: false, input_html: { style: 'display: none;' }
      #f.input :media_type, as: :select, collection: %i(music video), include_blank: false
      f.input :description, label: '説明文'
      f.input :billing_method, label: '課金方法', as: :radio, collection: { '無料' => :free, '有料' => :both  }
      #f.input :billing_method, as: :select, collection: %i(free in_app_purchase reward both), include_blank: false
      f.input :image_url, as: :file, label: 'ジャケット画像'
      f.input :youtube_url,
        placeholder: 'https://www.youtube.com/watch?v=v6kwUZQN7mU',
        label: 'youtube動画URL'
    end
    f.actions
  end

  controller do
    def label
      ActiveAdminLabel.new(current_staff.label)
    end

    def new
      @page_title = '楽曲登録'
      new!
    end

    class ActiveAdminLabel
      def initialize(label)
        @label = label
      end

      def items
        @label.item
      end
    end
  end
end
