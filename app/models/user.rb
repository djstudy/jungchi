class User < ActiveRecord::Base
  has_many :vote_results

	def make_score(representatives)
    user_result= self.vote_results
    result_a = []

    representatives.each do |r|
      point = 0
      r.vote_results.each do |r_vote_result|
        user_result.each do |a_user_result|
          if r_vote_result.vote_id == a_user_result.vote_id
            if result_same?(a_user_result.result, r_vote_result.result)
              point += 1
            elsif result_opposite?(a_user_result.result, r_vote_result.result)
              point -= 1
            end
          end
        end
      end
      result_a.push({representative: r, point: point})
    end
    result_a.sort { |a, b| -a[:point] <=> -b[:point] }
  end

  def result_same?(i,j)
    if i=="bandae" || i=="gigwon"
      j=="bandae" || j=="gigwon"
    else
      i==j
    end
  end

  def result_opposite?(i,j)
    if i=="bandae" || i=="gigwon"
      j== "chanseong"
    elsif i=="chanseong"
      j=="bandae" || j=="gigwon"
    end
  end

end

