require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "User_model 空白エラーテスト" do
    @user.name = " "
    @user.email = " "
    assert_not @user.valid?
  end
end
