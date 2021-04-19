class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :blank_password, only: :update

  def new; end

  def edit; end

  def update
    if @user.update(user_params)
      log_in @user
      flash[:success] = t "password.be_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "password.reset_email"
      redirect_to root_url
    else
      flash.now[:danger] = t "pasword.invalid_email"
      render :new
    end
  end

  private

  def get_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = "sample_app.index.nil_user"
    redirect_to root_path
  end

  def valid_user
    return if @user.activated && @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "password.reset_expired"
    redirect_to new_password_reset_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def blank_password
    render :edit if @user.blank_password_validator(user_params[:password])
  end
end
