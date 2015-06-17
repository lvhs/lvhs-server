require 'csv'
require 'json'

namespace :event_sites do
  task import: :environment do
    file = Rails.root.join(*%w[src event_sites master.csv])
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      %i(name address).each { |attr| row[:name].gsub!(/\n+/, '') }
      next if EventSite.find_by(name: row[:name], prefecture: row[:prefecture]).present?
      EventSite.create! row.to_h
    end
  end
end
