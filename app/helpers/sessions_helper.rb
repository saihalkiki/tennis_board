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
