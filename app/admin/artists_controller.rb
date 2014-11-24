class Admin::ArtistsController < ActiveAdmin::ResourceController
  def label
    Label.new(current_staff.label)
  end

  class Label
    def initialize(label)
      @label = label
    end

    def artists
      @label.artist
    end
  end
end
