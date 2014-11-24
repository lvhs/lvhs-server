ActiveAdmin.register PurchasedItem do

  index do
    selectable_column
    id_column
    column :key
    column(:item) { |purchased_item| Item.find(purchased_item.item_id).name }
    column(:price) { "¥100" }
  end

end
