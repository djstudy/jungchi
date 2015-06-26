class Vote < ActiveRecord::Base
  has_many :vote_results
  has_many :vote_infos
end
