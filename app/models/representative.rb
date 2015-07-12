class Representative < ActiveRecord::Base
  has_many :vote_results
  has_many :vote_infos, foreign_key: :speaker_id

  def profile_result_og_img_url


      # result = "#{request.protocol}#{request.host_with_port}"
      result = ActionController::Base.helpers.image_path( "#{id}.jpg")

  end

  def profile_result_img_url
    ActionController::Base.helpers.asset_path( "#{id}.jpg")
    # "http://watch.peoplepower21.org/images/member/#{id}.jpg"
  end

  def profile_img_url
    # ActionController::Base.helpers.asset_path( "#{id}.jpg")
    "http://watch.peoplepower21.org/images/member/#{id}.jpg"
  end

  def profile_party_img_url
    if party == " 현직 국회의원이 아닙니다."
      ActionController::Base.helpers.asset_path( "not_representative.png")
    else
      ActionController::Base.helpers.asset_path( "#{party}.png")
    end
  end

  def profile_combo_info
      "(#{combo}선)"
  end

end
