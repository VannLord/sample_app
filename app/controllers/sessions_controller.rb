class SessionsController < ApplicationController
  def new
    return unless current_user

    redirect_to root_path
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t "sample_app.index.invalid_account"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
