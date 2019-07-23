class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: %w(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email]
    
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:notice] = t ".password_reset"
      redirect_to root_url
    else
      flash.now[:danger] = ".email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.erros.add :password, t(".cannot_be_empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t ".password_has_been_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
          .permit %w(password password_confirmation)
  end
  
  def load_user
    @user = User.find_by email: params[:email]
    redirect_to root_url unless @user
  end

  def valid_user
    redirect_to root_url unless
      @user.valid? && @user.authenticated?(:reset, params[:id])
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t ".reset_password_expired"
      redirect_to new_password_reset_url
    end
  end
end