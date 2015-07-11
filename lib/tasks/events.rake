require 'csv'
require 'json'

namespace :events do
  task import: :environment do
    file = Rails.root.join(*%w[src events master.csv])
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      event = Event.new
      event.scheduled_at = Time.zone.parse row[:scheduled_at]
      event.artist = Artist.find_by_name row[:artist_name]
      event.event_site = EventSite.find_by_name row[:event_site_name]
      event.save
    end
  end
end
