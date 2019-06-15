require 'test_helper'

class LayoutSiteTest < ActionDispatch::IntegrationTest

  test "レイアウトリンクのテスト" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]",signup_path
  end
end
