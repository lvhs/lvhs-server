require 'csv'
require 'json'

namespace :event_sites do
  task import: :environment do
    file = Rails.root.join(*%w[src event_sites master.csv])
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      %i(name address).each { |_attr| row[:name].gsub!(/\n+/, '') }
      prefecture = Prefecture.find_by(name: row[:prefecture])
      next if EventSite.find_by(name: row[:name], prefecture_id: prefecture.id).present?
      EventSite.create!(
        name: row[:name],
        prefecture_id: prefecture.id,
        postal_code: row[:postal_code],
        address: row[:address],
        phone: row[:phone]
      )
    end
  end
end
