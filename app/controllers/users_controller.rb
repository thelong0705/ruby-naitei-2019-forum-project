class UsersController < ApplicationController
  before_action :load_user, only: %w(show)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  private
  
  def load_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user
  end  

  def user_params
    params.require(:user).
      permit %w(avatar name email password password_confirmation)
  end
end
