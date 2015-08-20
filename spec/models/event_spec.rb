# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :text(65535)
#  scheduled_at  :datetime         not null
#  event_site_id :integer          not null
#  artist_id     :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_events_on_artist_id_and_event_site_id_and_scheduled_at  (artist_id,event_site_id,scheduled_at) UNIQUE
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
