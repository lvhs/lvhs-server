require 'csv'

namespace :jasrac do
  dt = Time.current.strftime("%Y-%m")
  movie_file = Rails.root.join('tmp', 'jasrac', "movie-#{dt}.tsv")
  label_file = Rails.root.join('tmp', 'jasrac', "label-#{dt}.tsv")
  sales_file = Rails.root.join('tmp', 'jasrac', "sales-#{dt}.tsv")

  task movie: :environment do
    CSV.open(movie_file, 'w', col_sep: "\t") do |csv|
      Item.find_each do |i|
        csv << [i.id, i.artist.name, i.name, (i.free? ? 0 : 120), !i.free?, nil, i.updated_at.strftime('%Y/%m')]
      end
    end
  end

  task label: :environment do
    CSV.open(label_file, 'w', col_sep: "\t") do |csv|
      ArtistGroup.find_each do |g|
        g.artist.find_each do |a|
          csv << [a.name, g.name]
        end
      end
    end
  end

  task sales: :environment do
    CSV.open(sales_file, 'w', col_sep: "\t") do |csv|

      data = {}
      PurchasedItem.find_each do |pi|
        i = Item.find_by(id: pi.item_id)
        next if i.nil?
        device = Device.find_by(key: pi.key)
        rhs = RewardHistory.where(device_id: device.id)
        id = i.id
        dt = pi.updated_at < Time.new(2015, 5, 20) ? Time.new(2015,5,20).strftime("%Y-%m") : pi.updated_at.strftime("%Y-%m")

        data[id] ||= {}

        data[id][dt] ||= {
          iap:    {n: 0, s: 0},
          reward: {n: 0, s: 0}
        }

        if rhs.empty? || rhs.find_by(item_id: i.id).nil?
          # 売上
          data[id][dt][:iap][:n] += 1
          data[id][dt][:iap][:s] += 120 * 0.7
        else
          # リワード
          data[id][dt][:reward][:n] += 1
          data[id][dt][:reward][:s] += rhs.find_by(item_id: i.id).point
        end
      end

      Item.find_each do |item|
        if data[item.id]
          data[item.id].each_pair do |d, data1|
            csv << [
              item.id, item.artist.name, item.name, item.free? ? 0 : 120, 0,
              data1[:iap][:n],
              data1[:iap][:s],
              data1[:reward][:n],
              data1[:reward][:s],
              0,
              item.artist.artist_group.name,
              dt,
            ]
          end
        else
          csv << [item.id, item.artist.name, item.name, item.free? ? 0 : 120, 0, 0, 0, 0, 0, 0, item.artist.artist_group.name, nil]
        end
      end
    end
  end
end

task :all => ["jasrac:movie", "jasrac:label", "jasrac:sales"]
