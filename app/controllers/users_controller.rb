class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user

    flash[:danger] = t "sample_app.index.nil_user"
    redirect_to new_user_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:sucess] = t "sample_app.index.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
