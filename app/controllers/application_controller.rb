class ApplicationController < ActionController::API
  def validate_fe
    if params[:be_auth_key] != ENV['be_auth_key']
      render json: { "error": "bad authentication key" }, status: 401
    end
  end
end
