class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "sample_app.index.activated"
      redirect_to user
    else
      flash[:danger] = t "sample_app.index.invalid_active_link"
      redirect_to root_url
    end
  end
end
