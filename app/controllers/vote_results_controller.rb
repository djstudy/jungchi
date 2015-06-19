class VoteResultsController < ApplicationController
  def index

  end
  def start
    current_user = User.create()
    session[:user_id] = current_user.id
    redirect_to new_vote_result_path
  end

  def new


  end

  def create



  end

  def report

  end
end
