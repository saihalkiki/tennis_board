require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)  # 「fixtures」の「users」の「michael」
  end

  test "編集失敗のテスト" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "", email: "abc@abc", password: "yaa", password_confirmation: "gyaa"}}
    assert_template 'users/edit'

  end

# フレンドリーフォワーとは？ => ユーザーが認証前に開こうとしていたページへ、認証後にリダイレクトさせること
  test "フレンドリーフォワーと編集成功のテスト" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,  email: email,  password: "", password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

end
