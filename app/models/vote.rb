class Vote < ActiveRecord::Base
  has_many :vote_resultes
  has_many :vote_infos
end
