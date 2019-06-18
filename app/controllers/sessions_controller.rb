class SessionsController < ApplicationController
  def new
  end

  # POST /login
  # ログイン・ログイン保持アクション
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user) # session[user_id]の保存
      remember(@user) # cookies.signed[:user_id]の保存とランダムな[:remember_token]を生成し、[:remember_digest]属性にも保存
      redirect_to @user
    else
      flash.now[:danger] = "ログイン出来ませんでした。メールアドレスとパスワードを再確認して下さい。"
      render 'sessions/new'
    end
  end

# DELETE /logout
# ログアウトアクション
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
