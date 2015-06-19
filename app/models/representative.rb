class Representative < ActiveRecord::Base
  has_many :vote_results
end
