class PrivateController < ApplicationController
  before_action :authorize

  def private
    render json: { message: 'All good. You only get this message if you\'re authenticated.' }
  end

  def private_scoped
    validate_permissions ['read:messages'] do
      render json: { message: 'All good. You only get this message if you\'re authenticated and have a scope of read:messages.' }
    end
  end
end
