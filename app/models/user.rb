class User < ActiveRecord::Base
  has_many :vote_results

	def make_score
    user_result= self.vote_results
    result_a = []
    user_result.each do |a_user_result|
      this_results = VoteResult.where(vote_id: a_user_result.vote_id).where(user_id: nil).where(result: a_user_result.result)
      Representative.all.each do |r|
        result_a.push({representative: r, count: this_results.where(representative_id: r.id).count} )
      end
    end
    result_a

      
  end  
end
