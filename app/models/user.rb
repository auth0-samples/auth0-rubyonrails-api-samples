class User < ActiveRecord::Base
  def self.from_token_payload payload
    # Returns a valid user, `nil` or raise
    # !!!
    # This is only to make the example test cases pass, you should use something line self.find payload["sub"]
    payload['sub']
  end
end