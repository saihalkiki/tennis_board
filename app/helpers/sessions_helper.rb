module SessionsHelper
  # 渡されたユーザーでログインするヘルパー
  def log_in(user)
    session[:user_id] = user.id
  end


  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    # cookies.signed[:user_id] = { value: user.id, expires: 20.years.from_now.utc }
    cookies.permanent[:remember_token] = user.remember_token
    # cookies[:remember_token] = { value: user.remember_token, expires: 20.years.from_now.utc }
  end

  # 現在ログイン中のユーザー、もしくは、記憶トークンcookieに対応するユーザーを返し、いない場合はnilを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # ユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
