class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    decoded = JsonWebToken.decode(header)
    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
    end
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end
end
