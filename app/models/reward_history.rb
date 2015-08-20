# == Schema Information
#
# Table name: reward_histories
#
#  id          :integer          not null, primary key
#  device_id   :integer
#  cid         :integer
#  cname       :string(255)
#  carrier     :integer
#  click_date  :datetime
#  action_date :datetime
#  amount      :integer
#  commission  :integer
#  aff_id      :string(255)
#  point       :integer
#  pid         :integer
#  item_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  conversion  (cid,device_id,action_date,pid) UNIQUE
#

class RewardHistory < ActiveRecord::Base
end
