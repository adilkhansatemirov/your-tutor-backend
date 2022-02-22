require 'test_helper'
 
class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      first_name: "Tom", 
      last_name: "Berry", 
      email: "tom@email.com", 
      password: "password"
    )
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without first name' do
    @user.first_name = nil
    refute @user.valid?, 'saved user without a first name'
    assert_not_nil @user.errors[:first_name], 'no validation error for name present'
  end
  
  test 'invalid without last name' do
    @user.last_name = nil
    refute @user.valid?, 'saved user without a last name'
    assert_not_nil @user.errors[:last_name], 'no validation error for last name present'
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?, 'saved user without a email'
    assert_not_nil @user.errors[:email], 'no validation error for email present'
  end
  
  test 'invalid if not unique email' do
    one = User.create( 
      first_name: "Tom", 
      last_name: "Berry", 
      email: "tom@email.com", 
      password: "password"
    )
    refute @user.valid?, 'saved user without unique email'
    assert_not_nil @user.errors[:email], 'no validation error for email uniqueness'
  end
  
  test 'invalid without password' do
    @user.password = nil
    refute @user.valid?, 'saved user without a password'
    assert_not_nil @user.errors[:password], 'no validation error for password present'
  end

end
