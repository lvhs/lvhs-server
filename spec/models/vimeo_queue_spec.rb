# == Schema Information
#
# Table name: vimeo_queues
#
#  id         :integer          not null, primary key
#  artist_id  :integer          not null
#  title      :string(255)
#  vimeo_id   :integer
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_vimeo_queues_on_artist_id_and_vimeo_id  (artist_id,vimeo_id) UNIQUE
#

require 'rails_helper'

RSpec.describe VimeoQueue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
