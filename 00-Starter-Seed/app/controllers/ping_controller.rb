class PingController < ActionController::API
  def ping
    render json: "All good. You don't need to be authenticated to call this"
  end
end
