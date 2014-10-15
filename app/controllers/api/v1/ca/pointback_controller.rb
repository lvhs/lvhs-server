class Api::V1::Ca::PointbackController < Api::V1::ApiController
  def index
    render text: 'OK', status: 200
  end
end
