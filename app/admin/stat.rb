ActiveAdmin.register_page 'Stat' do
  content do
    table_for Item.all do
      column(:artist) { |item| item.artist.name }
      column :name
      column('売上') { 100 }
    end
  end

  controller do
    def show
      @page_title = 'hogehoge'
    end

    def content
      @page_title = 'hogehoge'
      content!
    end
  end
end
