module SessionsHelper
  # 渡されたユーザーでログインするヘルパー
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーデータ(いない場合はnilを返す)
  def current_user
    if !!session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      # session[:user_id] = user.id
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
