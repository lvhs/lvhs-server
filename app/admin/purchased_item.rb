ActiveAdmin.register PurchasedItem do
  menu label: '購入履歴', priority: 20

  index do
    selectable_column
    id_column
    column :key
    column(:item) { |purchased_item| Item.find(purchased_item.item_id).name }
    column(:price) { "100" }
  end

end
