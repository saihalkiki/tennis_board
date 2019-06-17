class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to @user
    else
      flash.now[:danger] = "ログイン出来ませんでした。メールアドレスとパスワードを再確認して下さい。"
      render 'sessions/new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
