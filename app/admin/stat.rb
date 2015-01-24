ActiveAdmin.register_page 'Stat' do
  menu label: '売上', priority: 12

  content title: '売上' do
    columns do
      column do
        panel '売上' do
          items = current_staff.admin? ? Item : Item.artist(artist_group_id: current_staff.artist_group.id)
          table_for items do
            column('アーティスト') { |item| item.artist.name }
            column '動画', :name
            column('売上') { 100 }
          end
        end
      end
    end
  end

  sidebar :help do
    form role: 'form' do |f|
      div class: 'radio' do
        f.input '累計', name: :period, type: :radio, value: :total,
                      checked: params[:period].nil? || params[:period] == 'total'
        f.input '月間', name: :period, type: :radio, value: :monthly,
                      checked:  params[:period] == 'monthly'
        f.input '週間', name: :period, type: :radio, value: :weekly,
                      checked: params[:period] == 'weekly'
        f.input '日間', name: :period, type: :radio, value: :daily,
                      checked: params[:period] == 'daily'
      end
      div class: 'form-group' do
        f.input 'foo', type: :date
      end
      div do
        f.button '送信'
      end
    end
  end
end
