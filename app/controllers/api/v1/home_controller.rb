class Api::V1::HomeController < Api::V1::ApiController
  def index
    render json: { ok: true }, status: 200
  end
end
