class ApplicationController < ActionController::API
  def validate_fe  
    if request.headers['HTTP_BE_AUTH_KEY'] != ENV['be_auth_key']
      render json: { "error": "bad authentication key" }, status: 401
    end
  end
end
