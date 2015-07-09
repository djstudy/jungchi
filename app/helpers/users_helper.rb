module UsersHelper
  def btn_active(user)
    'disabled' if session[:user_id]!=user.id
  end
end
