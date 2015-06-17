class App::HomeController < App::BaseController
  def index
    first_view_items = 3
    if params[:rest]
      @artists = Artist.available[first_view_items..-1]
      @rest = true
      render partial: 'artist_list', layout: false, locals: { artists: @artists, rest: @rest }
    else
      @artists = Artist.available.take(first_view_items)
    end
  end
end
