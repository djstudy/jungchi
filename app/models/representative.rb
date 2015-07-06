class Representative < ActiveRecord::Base
  has_many :vote_results
  has_many :vote_infos, foreign_key: :speaker_id

  def profile_result_img_url
    ActionController::Base.helpers.asset_path( "#{id}.jpg") 
    # "http://watch.peoplepower21.org/images/member/#{id}.jpg"
  end

  def profile_img_url
    # ActionController::Base.helpers.asset_path( "#{id}.jpg") 
    "http://watch.peoplepower21.org/images/member/#{id}.jpg"
  end

end
