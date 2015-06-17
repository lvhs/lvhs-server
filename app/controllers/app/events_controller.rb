class App::EventsController < App::BaseController
  before_action :check_confirmation, except: [:welcome]

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

  def welcome
    redirect_to :app_events unless first_time?
    @user = User.create! device_id: @device.id
  end

  private

  def check_confirmation
    redirect_to :welcome_app_events if first_time?
  end

  def first_time?
    User.find_by(@device.id).nil?
  end
end
