class App::Events::EntryController < App::BaseController
  def create
    entry_params = params.permit(:event_id, :user_id)
    @entry = EventEntry.create! entry_params
    render json: @entry.decorate.to_json
  end

  def destroy
    EventEntry.find(params[:id]).delete
    render json: { status: 'OK' }
  end
end
