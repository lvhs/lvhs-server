require 'video_manager'
require 'static_manager'
require 'product_manager'

class VimeoMigrateHelper
  def self.diff
    VideoManager::MASTER.each_pair do |id, vimeo_id|
      apple_product_id = ProductManager.pid(id)
      vimeo_thumb_id = StaticManager.thumb_id(vimeo_id.to_i)
      item = Item.find(id)

      if id.present? && id != item.id
        puts "id: #{id} <=> #{item.id}"
      end
      if vimeo_id.present? && vimeo_id != item.vimeo_id
        puts "vimeo_id: #{vimeo_id} <=> #{item.vimeo_id}"
      end
      if vimeo_thumb_id.present? && vimeo_thumb_id != item.vimeo_thumb_id
        puts "vimeo_thumb_id: #{vimeo_thumb_id} <=> #{item.vimeo_thumb_id}"
      end
      if apple_product_id.present? && apple_product_id != item.apple_product_id
        puts "apple_product_id: #{apple_product_id} <=> #{item.apple_product_id}"
      end
    end
  end

  def self.update
    VideoManager::MASTER.each_pair do |id, vimeo_id|
      apple_product_id = ProductManager.pid(id)
      vimeo_thumb_id = StaticManager.thumb_id(vimeo_id.to_i)
      item = Item.find(id)

      params = {}
      params[:apple_product_id] = apple_product_id.to_s if apple_product_id.present?
      params[:vimeo_thumb_id] = vimeo_thumb_id.to_i if vimeo_thumb_id.present?
      params[:vimeo_id] = vimeo_id.to_i if vimeo_id.present?

      item.update_attributes! params
    end
  end
end

def main
  case ARGV.first
  when "update"
    VimeoMigrateHelper.update
  else
    VimeoMigrateHelper.diff
  end
end

if __FILE__ == $PROGRAM_NAME
    main
end
