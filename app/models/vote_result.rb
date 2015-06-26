class VoteResult < ActiveRecord::Base
  validates :result, inclusion: ["chanseong", "bandae", "gigwon", "boolcham", "chooljang", "cheongga", "gyeolseok"]

  belongs_to :user
  belongs_to :representative
  belongs_to :vote
end
