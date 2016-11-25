# frozen_string_literal: true
class SecuredPingController < ActionController::API
  include Secured

  def ping
    render json: "All good. You only get this message if you're authenticated."
  end
end
