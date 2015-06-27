require 'csv'
require 'json'

namespace :prefecture do
  task import: :environment do
    file = Rails.root.join(*%w[src prefecture master.csv])
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      next if Prefecture.find_by(name: row[:name]).present?
      Prefecture.create! row.to_h
    end
  end
end
