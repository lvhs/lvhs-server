# == Schema Information
#
# Table name: items
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  media_type       :integer          default(1), not null
#  description      :text(65535)
#  artist_id        :integer          not null
#  price            :integer
#  billing_method   :integer          default(3), not null
#  finished_at      :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  image_path       :string(255)
#  status           :integer          default(0)
#  published_at     :datetime
#  vimeo_id         :string(255)
#  apple_product_id :string(255)
#  vimeo_thumb_id   :integer
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
