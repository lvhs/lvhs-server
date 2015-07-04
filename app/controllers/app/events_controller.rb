class App::EventsController < App::BaseController
  before_action :set_user

  def index
    @events = EventDecorator.decorate_collection Event.includes(:prefecture).includes(:artist).all
    @event_entries = EventDecorator.decorate_collection Event.joins(:event_entries).merge(EventEntry.where(user_id: @user.id))
  end

  def show
    @event = Event.find(params[:id])
    @event_comments = EventCommentDecorator.decorate_collection @event.comments.includes(:user)
    @event_entry = EventEntry.find_by(event_id: @event.id, user_id: @user.id)
  end

  def new
    @event = Event.new
    @artists = Artist.all
    @event_sites = EventSite.all
    @prefectures = Prefecture.all
  end

  def create
    event_params = params.require(:event).permit(:artist_id, :event_site_id, :scheduled_at)
    event_params[:scheduled_at] = Date.parse(event_params[:scheduled_at]).in_time_zone

    @event = Event.find_or_initialize_by event_params
    if !Event.find_by(event_params) && @event.save
      redirect_to app_events_url(@event)
    else
      puts @event.errors.as_json
      @artists = Artist.all
      @event_sites = EventSite.all
      @prefectures = Prefecture.all
      render :new
    end
  end

  def edit

  end

  def update

  end

  private

  def set_user
    @user = User.find_or_create_by_device_id(@device.id)
  end
end
