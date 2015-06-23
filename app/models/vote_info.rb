class VoteInfo < ActiveRecord::Base
  belongs_to :vote
  belongs_to :representative, foreign_key: :speaker_id



end
