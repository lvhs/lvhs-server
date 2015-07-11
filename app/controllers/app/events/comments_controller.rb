class App::Events::CommentsController < App::BaseController
  def create
    comment_params = params.permit(:event_id, :user_id, :body)
    @comment = EventComment.new comment_params
    render json: { status: @comment.save ? 'OK' : 'NG' }
  end
end
