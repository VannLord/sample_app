class SessionsController < ApplicationController
  def new
    return unless current_user

    redirect_to root_path
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      if user.activated
        handle_logged_in user
      else
        flash[:warning] = t "sample_app.index.not_activated"
        redirect_to root_url
      end
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
