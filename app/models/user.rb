class User < ActiveRecord::Base
  has_one :device

  PROF_IMAGE_PATTERN = 'profile/%03d.jpg'

  RANDOM_PROF_IMAGES = (0..15).to_a
  RANDOM_PROF_NAME_FILE = Rails.root.join('src', 'profile', 'name.txt')

  def image_no
    image_path[/\d+/].to_i
  end

  def image_no=(no)
    self.image_path = (PROF_IMAGE_PATTERN % no.to_i)
  end

  private

  class << self
    def find_or_create_by_device_id(id)
      find_by(device_id: id) || create(
        device_id: id,
        name: random_name,
        image_path: random_image_path
      )
    end

    def random_image_path
      PROF_IMAGE_PATTERN % RANDOM_PROF_IMAGES.sample
    end

    def random_name
      random_names.sample
    end

    def random_names
      @random_names ||= [].tap do |names|
        File.open(RANDOM_PROF_NAME_FILE).each do |l|
          names << l.chomp
        end
      end
    end
  end
end
