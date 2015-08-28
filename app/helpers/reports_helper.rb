module ReportsHelper
	def score_calc(yes_arr, no_arr, result_id)
		number_no   = no_arr[result_id]
		number_yes = yes_arr[result_id]

		if number_no + number_yes > 0
			return (number_yes / (number_no + number_yes).to_f)*100
		else
			return 0
		end



	end
end
