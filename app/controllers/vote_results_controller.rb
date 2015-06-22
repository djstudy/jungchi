class VoteResultsController < ApplicationController
  before_action :authenticate!, except: [:index, :start]
  def index

  end
  def start
    current_user = User.create()
    session[:user_id] = current_user.id
    redirect_to new_vote_result_path

  end

  def new

    @user = User.find(session[:user_id])
    vote_count = @user.vote_results.all.count
    if vote_count >= TOTAL_VOTING_NUMBER
      redirect_to report_vote_result_path(@user)
    else
      @vote = Vote.all.order(:id).all[vote_count]
      @vote_result = VoteResult.new
      @vote_percentage = get_percentage
    end
  end

  def create
    @vote_result = VoteResult.new(vote_result_params)
    @vote_result.user_id = params[:user_id]
    @vote_result.vote_id = params[:vote_id]

    if @vote_result.save
      redirect_to new_vote_result_path
    else
      @user = User.find(session[:user_id])
      vote_count = @user.vote_results.all.count
      @vote = Vote.all.order(:id).all[vote_count]
      @vote_percentage = get_percentage

      render "new"
    end
    # raise @vote_result.inspect
    # VoteResult.create(user: @user, vote: @vote, result: params[:result]))

  end


  def report
  	if ( @user = User.find_by_id(params[:id]))
      vote_count = @user.vote_results.all.count

      if vote_count < TOTAL_VOTING_NUMBER
        redirect_to new_vote_result_path
      end


      @reporting_results = @user.make_score
    else
      raise '잘못된 접근'
    end

  end

private
  def vote_result_params
    params.fetch(:vote_result, {}).permit(:result)
  end

  def authenticate!
    if !session[:user_id]
      redirect_to vote_results_path
    end
  end

  def get_percentage
    @user = User.find(session[:user_id])
    vote_count = @user.vote_results.all.count
    100 * (vote_count / TOTAL_VOTING_NUMBER.to_f)
  end
end
