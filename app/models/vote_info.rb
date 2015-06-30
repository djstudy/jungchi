class VoteInfo < ActiveRecord::Base
  INFO_TYPES = ["prev", "yes", "no"]
  INFO_TYPES.each  do |type|
    define_method("is_#{type}?") do
      info_type == type
    end
  end

  belongs_to :vote
  belongs_to :representative, foreign_key: :speaker_id
  scope :opinions, -> {
    vote_infos = VoteInfo.arel_table
    where(vote_infos[:info_type].not_eq("prev")).order(:sequence)
  }



  def self.previously
    find_by_info_type("prev")
  end

end
