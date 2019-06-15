require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "User_model空白エラーテスト" do
    @user.name = "  "
    @user.email = " "
    assert_not @user.valid?
  end

  test "名前の長さ制限テスト" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "メールアドレスの長さ制限テスト" do
    @user.name = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "無効なメールフォーマットテスト" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "重複登録拒否のテスト" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "メールアドレスは全て小文字で保存されるテスト" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

end
