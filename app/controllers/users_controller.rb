class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    if @user.update(user_email_params)
      redirect_to report_vote_result_path(@user.id)
    else
      render "fucked!"
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_email_params
      params.require(:user).permit(:email)
    end
end
