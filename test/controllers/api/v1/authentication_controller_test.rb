require 'test_helper'

class Api::V1::AuthenticationControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  
  def setup
    @user = users(:one)
  end

  test 'valid check email' do
    post(:check_by_email, params: { email: @user.email})
    assert_response :success
  end

  test 'invalid check email' do
    user = users(:one)
    post(:check_by_email, params: { email: "notexist@gmail.com"})
    assert_response :unauthorized
  end

  test "valid create" do
    assert_difference "User.count" do
      post(:create, params: {
        first_name: "Tom",
        last_name: "Vart",
        email: "tom@email.com",
        password: "password"
      })
    end
    assert_response :success
  end

  test "invalid create" do
    assert_no_difference "User.count" do
      post(:create, params: {
        first_name: nil,
        last_name: nil,
        email: nil,
        password: nil
      })
    end
    assert_response :unprocessable_entity
  end

  test 'valid login' do
    post(:login, params: {
      email: users(:admin).email,
      password: "password"
    })
    assert_response :success
  end

  test 'invalid login, with incorrect email' do
    post(:login, params: {
      email: "notexist@email.com",
      password: "password"
    })
    assert_response :unauthorized
  end

  test 'invalid login, with incorrect password' do
    post(:login, params: {
      email: users(:admin).email,
      password: "incorrect password"
    })
    assert_response :unauthorized
  end

  test 'valid reset password' do
    post(:reset_password, params: {
      email: users(:admin).email,
      password: "password"
    })
    assert_response :success
  end

  test 'invalid reset password, with incorrect email' do
    post(:reset_password, params: {
      email: "notexist@email.com",
      password: "password"
    })
    assert_response :unauthorized
  end

end
