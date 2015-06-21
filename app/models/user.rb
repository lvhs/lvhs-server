class User < ActiveRecord::Base
  RANDOM_PROF_IMAGES = (0..15).to_a
  RANDOM_PROF_NAME_FILE = Rails.root.join('src', 'profile', 'name.txt')

  def self.find_or_create_by_device_id(id)
    find_by(device_id: id) || create(
      device_id: id,
      name: random_name,
      image_path: random_image_path
    )
  end

  private

  class << self
    def random_image_path
      "profile/%03d.jpg" % RANDOM_PROF_IMAGES.sample
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
