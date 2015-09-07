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
    @votes = Vote.order(:id)
  	reps.each do |r|
      reps_score[r.id] = 0
  		r_vote_results = r.vote_results
  		r_vote_results.each do |r_vote|
  			if r_vote.result == "chanseong"
  				reps_score[r.id] += @yes_table[r_vote.vote_id]
  			elsif r_vote.result == "bandae" || r_vote.result == "gigwon"
  				reps_score[r.id] += @no_table[r_vote.vote_id]
        else
          reps_score[r.id] += ( @no_table[r_vote.vote_id] + @yes_table[r_vote.vote_id] ) * 0.5
  			end
  		end
  	end
  	top_reps =reps_score.sort_by {|_key, value| -value}
  	@top3_with_score = top_reps[0..2].map{ |rep| {rep: Representative.find(rep[0]), score: rep[1]} }
    @last_with_score = {rep: Representative.find(top_reps.last[0]), score: top_reps.last[1] }

    score_data = top_reps.map{ |rep| rep[1]}
    @score_mean = score_data.mean
    @score_std = score_data.standard_deviation

  	final_scores = []
  	top_reps.each do |d|
  		final_scores.push(d[1])
  	end

    party_scores = {}
    reps_score.each do |rep_score|
      party_scores[Representative.find(rep_score[0]).party] = {score: 0, count: 0} if !party_scores[Representative.find(rep_score[0]).party]
      party_scores[Representative.find(rep_score[0]).party][:score] += rep_score[1]
      party_scores[Representative.find(rep_score[0]).party][:count] += 1
    end

    @parties = party_scores.map { |k,v| {name: k.strip, total_score: v[:score], avg_score: v[:score]/v[:count].to_f, count: v[:count]} }
    @parties = @parties.sort_by! {|e| -e[:avg_score]}


  	@reps_yes_table = Hash.new
  	@reps_no_table = Hash.new

    Vote.all.each do |v|
      aggr = v.vote_results.where(user_id: nil).group(:result).count
      @reps_yes_table[v.id] = aggr["chanseong"]
      @reps_no_table[v.id] = aggr["bandae"] + aggr["gigwon"]
    end





  end




end
