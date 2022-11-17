# frozen_string_literal: true
class PublicController < ApplicationController
  def public
    render json: { message: 'You don\'t need to be authenticated to call this' }
  end
end
