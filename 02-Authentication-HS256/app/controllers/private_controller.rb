class PrivateController < ApplicationController
  before_action :authorize

  def private
    render json: { message: 'All good. You only get this message if you\'re authenticated.' }
  end

  def private_scoped
    validate_permissions ['read:messages'] do
      render json: { message: 'Hello from a private endpoint! You need to be authenticated and have a scope of read:messages to see this.' }
    end
  end
end
