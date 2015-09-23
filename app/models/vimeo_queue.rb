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

class VimeoQueue < ActiveRecord::Base
  belongs_to :artist
  enum status: { created: 0, uploaded: 1 }

  def vimeo_uri=(uri)
    self.vimeo_id = vimeo_id_from_uri(uri)
  end

  def obsoleted?
    self.status == 'created' && self.created_at <= Time.current - 30.minutes
  end

  private

  def vimeo_id_from_uri(uri)
    uri.gsub(/\/videos\//, '').to_i
  end
end
