class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])

    else
      flash.now[:danger] = "ログイン出来ませんでした。メールアドレスとパスワードを再確認して下さい。"
      render 'sessions/new'
    end
  end

  def destroy
  end

end
