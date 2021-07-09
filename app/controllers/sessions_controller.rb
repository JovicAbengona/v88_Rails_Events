class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @states = State.all
  end

  def create
    user = User.find_by_email(user_params[:email]).try(:authenticate, user_params[:password])
    if user
      session[:user_id] = user.id
      redirect_to "/events"
    else
      redirect_to "/"
      flash[:login_error] = "Invalid Email or Password"
    end
  end

  def destroy
    reset_session
    redirect_to "/"
  end

  private 
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
