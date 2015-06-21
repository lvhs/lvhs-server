class App::EventsController < App::BaseController
  before_action :set_user

  def index
    @events = Event.all
  end

  def show

  end

  def edit

  end

  def update

  end

  def new
    @event = Event.new
    @artists = Artist.all
    @event_sites = EventSite.all
  end

  def create

  end

  private

  def set_user
    @user = User.find_or_create_by_device_id(@device.id)
  end
end
