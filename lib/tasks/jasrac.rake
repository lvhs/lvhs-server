require 'csv'
require 'pry'

namespace :jasrac do
  dt = Time.current.strftime("%Y-%m")
  movie_file = Rails.root.join('tmp', 'jasrac', "movie-#{dt}.tsv")
  label_file = Rails.root.join('tmp', 'jasrac', "label-#{dt}.tsv")
  sales_file = Rails.root.join('tmp', 'jasrac', "sales-#{dt}.tsv")
  reward_file = Rails.root.join('tmp', 'jasrac', "reward-#{dt}.tsv")

  task movie: :environment do
    CSV.open(movie_file, 'w', col_sep: "\t") do |csv|
      Item.find_each do |i|
        csv << [i.id, i.artist.name, i.name, (i.free? ? 0 : 120), !i.free?, nil, i.updated_at.strftime('%Y/%m/%d')]
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
      uniq = {}
      PurchasedItem.find_each do |pi|
        i = Item.find_by(id: pi.item_id)
        if i.nil?
          next
        end
        device = Device.find_by(key: pi.key)
        rhs = RewardHistory.where(device_id: device.id)
        did = device.id
        iid = i.id
        dt = pi.updated_at <= Time.new(2015, 4, 30) ? Time.new(2015, 4, 30).strftime("%Y-%m") : pi.updated_at.strftime("%Y-%m")

        data[iid] ||= {}
        data[iid][dt] ||= {
          iap:    {n: 0, s: 0},
          reward: {n: 0, s: 0}
        }

        uniq[did] ||= {}
        if uniq[did][iid]
          next
        else
          uniq[did][iid] = true
        end

        if rhs.empty? || rhs.find_by(item_id: iid).nil?
          # 売上
          data[iid][dt][:iap][:n] += 1
          data[iid][dt][:iap][:s] += 120 * 0.7
        else
          # リワード
          data[iid][dt][:reward][:n] += 1
          data[iid][dt][:reward][:s] += rhs.find_by(item_id: iid).point
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
              d,
            ]
          end
        else
          csv << [item.id, item.artist.name, item.name, item.free? ? 0 : 120, 0, 0, 0, 0, 0, 0, item.artist.artist_group.name, nil]
        end
      end
    end
  end

  task reward: :environment do
    # RewardHistory(id: integer,
    #               device_id: integer,
    #               cid: integer,
    #               cname: string,
    #               carrier: integer,
    #               click_date: datetime,
    #               action_date: datetime,
    #               amount: integer,
    #               commission: integer,
    #               aff_id: string,
    #               point: integer,
    #               pid: integer,
    #               item_id: integer,
    #               created_at: datetime,
    #               updated_at: datetime)
    data = {}
    CSV.open(reward_file, 'w', col_sep: "\t") do |csv|
      RewardHistory.find_each do |rh|
        device = rh.device

        if !rh.item_id.nil?
          i = Item.find rh.item_id
          iid = i.id
        else
          iid = :not_associated
        end

        data[iid] ||= {}
        dt = rh.updated_at <= Time.new(2015, 4, 30) ? Time.new(2015, 4, 30).strftime("%Y-%m") : rh.updated_at.strftime("%Y-%m")
        data[iid][dt] ||= {n: 0, s: 0}
        data[iid][dt][:n] += 1
        data[iid][dt][:s] += rh.point
      end

      csv << %w(
          インターフェイスキーコード
          リクエスト回数
          課金回数
          課金売上（税込）
          広告DL数
          広告売上（税込）
          総売上額（税込）
          課金売上（税抜）
          広告売上（税抜）
          総売上額（税抜）
          アーティスト名
          動画名
          情報量（税抜）
          所属事務所
      )
      dt = '2015/06/30'
      Item.find_each do |item|
        if data[item.id]
          data[item.id].each_pair do |d, data1|
            csv << [
              d,
              item.id,
              '',
              '', '',
              data1[:n], data1[:s],
              '', '', '', '',
              '', '', '', # hidden
              item.artist.name,
              item.name,
              item.free? ? 0 : 111, 0,
              item.artist.artist_group.name,
            ]
          end
        else
          csv << [
            '2015-06',
            item.id,
            '',
            '', '',
            '', '',
            '', '', '', '',
            '', '', '', # hidden
            item.artist.name,
            item.name,
            item.free? ? 0 : 111,
            item.artist.artist_group.name,
          ]
        end
      end
      data[:not_associated].each_key do |dt|
        csv << [
          dt,
          0,
          '',
          '', '',
          data[:not_associated][dt][:n], data[:not_associated][dt][:s],
          '', '', '', '',
          '', '', '', # hidden
          '-',
          'リワード未使用',
          0,
          '-'
        ]
      end
    end
  end
  task :all => ["jasrac:movie", "jasrac:label", "jasrac:sales"]
end

