class RemoveYoutubeIdAndAddThumbId < ActiveRecord::Migration
  def change
    remove_column :items, :youtube_id
    add_column :items, :vimeo_thumb_id, :integer
  end
end
