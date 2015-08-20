# == Schema Information
#
# Table name: event_entries
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  event_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_event_entries_on_user_id_and_event_id  (user_id,event_id) UNIQUE
#

class EventEntry < ActiveRecord::Base
end
