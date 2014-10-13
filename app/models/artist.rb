class Artist < ActiveRecord::Base
  belongs_to :label
  validate :key_should_be_particular_format

  def key_should_be_particular_format
    unless key[/\A[a-zA-Z0-9_-]+\z/]
      errors.add(:key, 'は英数字と記号(-_)のみ使用できます。')
    end
  end
end
