ActiveAdmin.register Artist, label: 'アーティスト' do
  menu label: 'アーティスト', priority: 10

  scope_to :label, unless: proc { current_staff.admin? }

  permit_params :label_id, :name, :key, :description, :official_url
  #belongs_to :label

  index title: 'アーティスト一覧' do
    selectable_column
    id_column
    column('所属') { |artist| artist.label.name }
    column 'アーティスト名', :name
    column 'アーティストID', :key
    column '説明文', :description
  end

  form title: 'アーティスト登録' do |f|
    f.inputs 'アーティスト情報を入力してください' do
      if current_staff.admin?
        f.input :label, label: '所属', include_blank: false
      else
        f.input :label, label: '&nbsp;', value: current_staff.label_id, input_html: { disabled: true, style: 'display: none;' }
      end
      f.input :name,
        placeholder: 'MyFirstStory',
        label: 'アーティスト名'
      f.input :key,
        placeholder: 'myfirststory',
        label: 'アーティストID',
        hint: '半角英数字(小文字)と記号(-_)を入力できます。'
      f.input :description, label: '説明文'
      f.input :official_url,
        placeholder: 'http://myfirststory.net',
        label: 'オフィシャルサイトURL'
      f.input :image_url, as: :file, label: 'アーティスト画像'
    end
    f.actions
  end

  controller do
    def new
      @page_title = 'アーティスト登録'
      new!
    end

    def label
      Label.new(current_staff.label)
    end

    class Label
      def initialize(label)
        @label = label
      end

      def artists
        @label.artist
      end
    end
  end
end
