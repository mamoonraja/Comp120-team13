require 'test_helper'

class IncidentsViewTest < ActionController::TestCase

  test "has back button" do
    url1 = "/incidents/new"
    text1 = 'back'
    assert_select 'a[href=?]', url, { text: text1}
  end

  test "renders index" do
  	get :index
  	assert_template :index
    assert_template layout: "Layouts/application"
  end

end