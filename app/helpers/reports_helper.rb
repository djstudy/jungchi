module ReportsHelper
	def score_calc(yes_arr, no_arr, result_id)
		number_no   = no_arr[result_id]
		number_yes = yes_arr[result_id]

		if number_no + number_yes > 0
			return ((number_yes / (number_no + number_yes).to_f) * 100 ).round(2)
		else
			return 0
		end



	end
  def party_img_url(party)
    if party[:name] == " 현직 국회의원이 아닙니다." || party[:name] == "현직 국회의원이 아닙니다."
      image_path( "not_representative.png")
    else
      image_path( "#{party[:name]}.png")
    end
  end
end
