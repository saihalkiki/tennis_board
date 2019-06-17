require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "ログイン失敗時の動作テスト" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.blank?
    get root_path
    assert flash.blank?
  end
end
