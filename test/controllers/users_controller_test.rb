require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  test "ログインしている場合のusers_pathの動作テスト" do
    log_in_as(@user)
    get users_path
    assert_response :success
  end

  test "ログインしていない時、indexページ(ユーザー一覧)を開こうとした際、リダイレクトするテスト" do
    get users_path
    assert_redirected_to login_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "ログインしてない時に編集にアクセスした時、flash表示しリダイレクトさせるテスト" do
    get edit_user_path(@user)
    assert_not flash.blank?
    assert_redirected_to login_url
  end

  test "ログインしていない時に編集データを渡した時、flash表示し、リダイレクトさせるテスト" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.blank?
    assert_redirected_to login_url
  end

  test "別のユーザー編集にアクセスできない動作テスト" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    # assert flash.blank?
    assert flash.blank?
    assert_redirected_to root_url
  end

  test "別のユーザーが編集データを送信しても動作しないテスト" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.blank?
    assert_redirected_to root_url
  end

  test "別のユーザーがindexページ(ユーザー一覧)を開こうとした際、リダイレクトするテスト" do
    get users_path
    assert_redirected_to login_url
  end

  test "他のユーザーが管理権限を受け付けないようにするテスト" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { password: "password",  password_confirmation: "password",  admin: "true" } }
    assert_not @other_user.reload.admin?
  end

  test "ログインしてない場合、消去アクション受け付けずリダイレクトするテスト" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "ログインしているが管理ユーザーでない場合、消去アクションを受け付けずリダイレクトするテスト" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
