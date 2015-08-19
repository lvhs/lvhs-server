require 'csv'
require 'gmail/client'

data = {}

PurchasedItem.find_each do |pi|
  i = Item.find_by(id: pi.item_id)
  next if i.nil?

  device = Device.find_by(key: pi.key)

  rhs = RewardHistory.where(device_id: device.id)

  name = i.artist.name

  dt = pi.updated_at < Time.new(2015, 5, 20) ? Time.new(2015,5,20).strftime("%Y-%m-%d") : pi.updated_at.strftime("%Y-%m-%d")

  data[dt] ||= {}

  data[dt][name] ||= {
    iap: {n: 0, s: 0},
    reward: {n: 0, s: 0}
  }

  if rhs.empty? || rhs.find_by(item_id: i.id).nil?
    # 売上
    data[dt][name][:iap][:n] += 1
    data[dt][name][:iap][:s] += 120 * 0.7
  else
    # リワード
    data[dt][name][:reward][:n] += 1
    data[dt][name][:reward][:s] += rhs.find_by(item_id: i.id).point
  end
end

target_date = (Time.current - 1.day).strftime("%Y-%m-%d")
filename = Rails.root.join("tmp", "lvhs-sales_#{target_date}.csv")

CSV.open(filename, "w") do |csv|
  csv << %w[DATE ARTIST REWARD REWARD_SALE IAP IAP_SALE(120x0.7)]
  data.each_pair do |dt, d0|
    d0.each_pair do |n, d|
      csv << [dt, n, d[:reward][:n], d[:reward][:s], d[:iap][:n], d[:iap][:s]]
    end
  end
end

mail = Gmail::Client.new
mail.deliver from: "project.livehouse@gmail.com",
  to: ["myfirststory.nori@gmail.com", "project.livehouse@gmail.com"],
  subject: "[LIVEHOUSE] #{target_date} 売上情報",
  body: "添付のcsvを確認してください",
  file: filename
