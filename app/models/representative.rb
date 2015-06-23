class Representative < ActiveRecord::Base
  has_many :vote_results
  has_many :vote_infos, foreign_key: :speaker_id
end
