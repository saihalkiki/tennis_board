class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true,length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,length: {maximum: 255},
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  # メールアドレスの大文字小文字を無視した一意性
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  # test_fixture向けのdigestメソッドを追加->渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember_token
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrue
  def authenticated?(remember_token)
    BCrypt::Password.new(attribute_digest).is_password?(remember_token)
    # secure_passwordのソースコード：https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rbを参照
    # .is_password？メソッドは==と同等。bcrypt gemのソースコードのソースコードを参照：https://github.com/codahale/bcrypt-ruby/blob/master/lib/bcrypt/password.rb
  end

end
