class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :provider, :token, :secret
end
