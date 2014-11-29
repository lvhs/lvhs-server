ActiveAdmin.register_page 'Stat' do
  menu label: '売上', priority: 12

  content do
    items = current_staff.admin? ? Item : Item.artist(artist_group_id: current_staff.artist_group.id)
    table_for Item.artist(artist_group_id: current_staff.artist_group.id) do
      column(:artist) { |item| item.artist.name }
      column :name
      column('売上') { 100 }
    end
  end
end
