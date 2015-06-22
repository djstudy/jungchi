class VoteResult < ActiveRecord::Base
  validates :result, inclusion: ["yes", "no"]

  belongs_to :user
  belongs_to :representative
  belongs_to :vote
end
