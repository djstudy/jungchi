require 'descriptive_statistics'

class ReportsController < ApplicationController
  def index
  	finisher = User.all.select { |u| u.vote_results.count >= 6  && u.vote_results.find_by_vote_id(9041) != nil}
  	minus_time = 0
  	finisher.each do |t|
  		a_time = t.vote_results.find_by_vote_id(9041).created_at
  		b_time = t.created_at

  		minus_time += a_time - b_time
  	end

    lap_time = 0
    if finisher.count > 0
      lap_time = minus_time / finisher.count
    end
  	@report_users = [User.count, finisher.count,lap_time]
  	#raise report_users.inspect

  	all_vote_result = VoteResult.all
  	@yes_table = Hash.new
  	@no_table = Hash.new

    Vote.all.each do |v|
      aggr = v.vote_results.where(representative_id: nil).group(:result).count
      @yes_table[v.id] = aggr["chanseong"] || 0
      @no_table[v.id] = aggr["bandae"] || 0
    end


  	reps = Representative.all
  	reps_score = Hash.new
    @vote_id_arr = Vote.order(:id).pluck(:id).uniq
  	reps.each do |r|
  		r_vote_results = r.vote_results
  		r_vote_results.each do |r_vote|
  			if r_vote.result == "chanseong"
  				reps_score[r.id] = @yes_table[r_vote.vote_id]
  				reps_score[r.id] = reps_score[r.id] - @no_table[r_vote.vote_id]
  			elsif r_vote.result == "bandae"
  				reps_score[r.id] = @no_table[r_vote.vote_id]
  				reps_score[r.id] = reps_score[r.id] - @yes_table[r_vote.vote_id]
  			end
  		end
  	end
  	top_reps =reps_score.sort_by {|_key, value| -value}
  	@first  = reps.find(top_reps[0][0])
    @second  = reps.find(top_reps[1][0])
    @third  = reps.find(top_reps[2][0])
    #raise [@first, @second, @third].inspect
  	final_scores = []
  	top_reps.each do |d|
  		final_scores.push(d[1])
  	end


  	@reps_yes_table = Hash.new
  	@reps_no_table = Hash.new

    Vote.all.each do |v|
      aggr = v.vote_results.where(user_id: nil).group(:result).count
      @reps_yes_table[v.id] = aggr["chanseong"]
      @reps_no_table[v.id] = aggr["bandae"] + aggr["gigwon"]
    end


  end




end
