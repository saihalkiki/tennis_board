require 'test_helper'

class LayoutSiteTest < ActionDispatch::IntegrationTest

  test "レイアウトリンクのテスト" do
    get root_path
    assert_template 'static_pages/home'
  end
end
