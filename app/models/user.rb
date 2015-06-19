class User < ActiveRecord::Base
  has_many :vote_results
  
end
