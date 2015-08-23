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

FactoryGirl.define do
  factory :vimeo_queue do
    artist_id 1
title "MyString"
vimeo_id 1
status 1
  end

end
