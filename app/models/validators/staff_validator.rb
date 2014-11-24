class StaffValidator < ActiveModel::Validator
  def validate(record)
    if record.role == 'label' && record.label_id.nil?
      record.errors[:base] << "label_id must be specified when label role selected"
    end
  end
end
