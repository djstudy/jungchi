class VoteInfosController < ApplicationController
  http_basic_authenticate_with name: "djstudy", password: ENV['BASIC_AUTH_SECRET']

  def index
    @vote_infos = VoteInfo.all
  end

  def new
    @vote_info = VoteInfo.new
  end

  def create
    @vote_info = VoteInfo.new(vote_info_params)
    if @vote_info.save
      redirect_to vote_infos_path
    else
      render "fucked!"
    end
  end

  def edit
    @vote_info = VoteInfo.find(params[:id])
  end

  def update
    @vote_info = VoteInfo.find(params[:id])
    if @vote_info.update(vote_info_params)
      redirect_to vote_infos_path
    else
      render "fucked!"
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_info_params
      params.require(:vote_info).permit(:content_title, :content, :content_plus, :speaker_id , :sequence, :info_type)
    end
end
