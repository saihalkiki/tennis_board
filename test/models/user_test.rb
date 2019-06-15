require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "User_model email空白エラーテスト" do
    @user.email = " "
    assert_not @user.valid?
  end

end
