require 'vimeo/client'

class App::VideosController < App::BaseController
  def new
    artist_id = params[:aid] || 1
    @artist = Artist.find artist_id
    @queue = VimeoQueue.create artist_id: @artist.id
    @ticket = Vimeo::Client.new.generate_upload_ticket(
      queue_id: @queue.id,
      artist_id: @artist.id
    )
  end

  def title
    title_params = params.permit(:queue_id, :title)
    queue = VimeoQueue.find(title_params[:queue_id])
    queue.update_attributes! title: title_params[:title]
    render json: { status: :ok }
  end

  def callback
    queue = VimeoQueue.find(params[:queue_id])
    queue.vimeo_uri = params[:video_uri]
    queue.status = 'uploaded'
    queue.save!
    Item.create!(
      vimeo_id: queue.vimeo_id,
      artist_id: params[:artist_id],
      name: queue.title,
      media_type: 'video',
      billing_method: 'free',
      status: 'unavailable'
    )
  end
end
