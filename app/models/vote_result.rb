class VoteResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :representative
  belongs_to :vote
end
