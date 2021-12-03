require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    user_params= { name:  "",
            email: "foo@invalid",
            password:              "foo",
            password_confirmation: "bar" }
    patch user_path(@user), params: {user: user_params}
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    user_params= { name:  name,
                   email: email,
                   password:              "",
                   password_confirmation: "" }
    patch user_path(@user), params: {user: user_params}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
