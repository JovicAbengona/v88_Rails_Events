class UsersController < ApplicationController
  skip_before_action :require_login, except: [:edit, :update]

  def create
    user = User.new(user_params)

    if user.save
      flash[:reg_success] = "You have successfull registered!"
    else
      flash[:data_first_name] = user_params[:first_name]
      flash[:data_last_name] = user_params[:last_name]
      flash[:data_email] = user_params[:email]
      flash[:data_city] = user_params[:city]
      flash[:data_state] = user_params[:state]
      flash[:reg_errors] = user.errors.messages
    end
    redirect_to '/'
  end

  def edit
    @user = User.find(params[:id])
    @states = State.all
  end

  def update
    user = User.find(params[:id])
    if user.update(user_update_params)
      flash[:update_success] = "Profile Updated Successfully!"
    else
      flash[:update_errors] = user.errors.messages
    end
    redirect_to "/users/#{params[:id]}"
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state)
    end
end
