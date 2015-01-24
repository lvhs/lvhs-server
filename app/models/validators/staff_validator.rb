class StaffValidator < ActiveModel::Validator
  def validate(record)
    if record.role == 'label' && record.artist_group_id.nil?
      record.errors[:base] << 'artist_group_id must be specified when label role selected'
    end
  end
end
