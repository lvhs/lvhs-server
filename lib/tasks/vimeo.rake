require 'vimeo/client'
require 'gmail/client'

namespace :vimeo do
  task publish: :environment do
    VimeoQueue.all.each do |q|
      puts "obsoleted?: #{q.obsoleted?}"
      next q.delete if q.obsoleted?
      puts "status: #{q.status}"
      next if q.status == 'created'
      vimeo = Vimeo::Client.new
      item = Item.find_by vimeo_id: q.vimeo_id.to_i
      video_data = vimeo.get_videos(q.vimeo_id)
      puts video_data[:status]
      puts "video_status: #{video_data[:status]}"
      next if video_data[:status] != 'available'

      item.thumb_uri = video_data[:pictures][:uri]
      item.status = 'available'

      vimeo.update_videos q.vimeo_id, name: q.title, review_link: false

      Gmail::Client.new.deliver(
        to: 'project.livehouse@gmail.com',
        subject: '[LIVEHOUSE] 動画が公開されました',
        body: <<-EOS.strip_heredoc
        #{q.artist.name}の「#{q.title}」が公開されました。

        vimeo link: #{video_data[:link]}
        EOS
      )

      item.save!
      q.delete
    end
  end
end
