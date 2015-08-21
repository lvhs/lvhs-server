# == Schema Information
#
# Table name: event_sites
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  postal_code   :string(255)
#  address       :text(65535)
#  phone         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :integer          not null
#
# Indexes
#
#  index_event_sites_on_name_and_prefecture_id  (name,prefecture_id) UNIQUE
#

require 'rails_helper'

RSpec.describe EventSite, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
