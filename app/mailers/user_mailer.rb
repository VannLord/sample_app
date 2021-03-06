class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("sample_app.index.activation")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("password.reset")
  end
end
