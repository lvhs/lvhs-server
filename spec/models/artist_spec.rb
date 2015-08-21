# == Schema Information
#
# Table name: artists
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  key             :string(255)
#  description     :text(65535)
#  artist_group_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#  official_url    :string(255)
#  image_path      :string(255)
#  status          :integer          default(0)
#  published_at    :datetime
#

require 'rails_helper'

RSpec.describe Artist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
