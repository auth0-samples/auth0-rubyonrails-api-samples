# frozen_string_literal: true
class PublicController < ActionController::API
  def public
    render json: { message: 'All good. You don\'t need to be authenticated to call this' }
  end
end
