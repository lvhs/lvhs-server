require 'vimeo/client'
require 'gmail/client'

namespace :vimeo do
  task publish: :environment do
    VimeoQueue.all.each do |q|
      next q.delete if q.obsoleted?
      next if q.status == 'created'
      vimeo = Vimeo::Client.new
      item = Item.find_by vimeo_id: q.vimeo_id
      video_data = vimeo.get_videos(q.vimeo_id)
      next if video_data[:status] != 'available'
      item.thumb_uri = video_data[:pictures][:uri]
      item.status = 'available'
      item.save!
      vimeo.put_videos q.vimeo_id, name: q.title
      q.delete
      Gmail::Client.deliver(
        to: 'project.livehouse@gmail.com',
        subject: '[LIVEHOUSE] 動画が公開されました',
        body: <<-EOS.strip_heredoc
        #{q.artist.name}の「#{q.title}」が公開されました。

        vimeo link: #{video_data.link}
        EOS
      )
    end
  end
end
