require 'descriptive_statistics'

class ReportsController < ApplicationController
  def index
  	finisher = User.all.select { |u| u.vote_results.count >= 6}
  	minus_time = 0
  	finisher.each do |t|
  		a_time = t.vote_results.find_by_vote_id(9041).created_at
  		b_time = t.created_at

  		minus_time += a_time - b_time
  	end

  	lap_time = minus_time / finisher.count
  	report_users = [User.count, finisher.count,lap_time]
  	#raise report_users.inspect

  	all_vote_result = VoteResult.all
  	yes_table = Hash.new
  	no_table = Hash.new

  	all_vote_result.each do |v|
  		if yes_table[v.vote_id] == nil or no_table[v.vote_id] == nil
  			yes_table[v.vote_id] = 0
  			no_table[v.vote_id] = 0
  		end
  		if v.result == "chanseong"
  			yes_table[v.vote_id] = yes_table[v.vote_id] + 1
  		elsif v.result == "bandae"
  			no_table[v.vote_id] = no_table[v.vote_id] + 1
  		end
  	end

  	reps = Representative.all
  	reps_score = Hash.new

  	reps.each do |r|
  		r_vote_results = r.vote_results
  		r_vote_results.each do |r_vote|
  			if r_vote.result == "chanseong"
  				reps_score[r.id] = yes_table[r_vote.vote_id]
  				reps_score[r.id] = reps_score[r.id] - no_table[r_vote.vote_id]
  			elsif r_vote.result == "bandae"
  				reps_score[r.id] = no_table[r_vote.vote_id]
  				reps_score[r.id] = reps_score[r.id] - yes_table[r_vote.vote_id]
  			end
  		end
  	end
  	ddd =reps_score.sort_by {|_key, value| value}
  	#raise reps_score[0].inspect
  	puts reps_score[1]
  	puts reps_score[2]

  	final_scores = []
  	ddd.each do |d|
  		final_scores.push(d[1])
  	end
  	

  	reps_results = all_vote_result.select { |r| r.representative_id != nil }
  	reps_yes_table = Hash.new
  	reps_no_table = Hash.new

  	reps_results.each do |v|

  		if reps_yes_table[v.vote_id] == nil or reps_no_table[v.vote_id] == nil
  			reps_yes_table[v.vote_id] = 0
  			reps_no_table[v.vote_id] = 0
  		end

  		if v.result == "chanseong"
  			reps_yes_table[v.vote_id] = reps_yes_table[v.vote_id] + 1
  		elsif v.result == "bandae" or v.result == "gyeolseok" or v.result == "cheongga" or v.result == "boolcham" or v.result == "gigwon"
  			reps_no_table[v.vote_id] = reps_no_table[v.vote_id] + 1
  		end

  	end
  		raise final_scores.standard_deviation.inspect
  end




end
